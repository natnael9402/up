"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = __importDefault(require("express"));
const prisma_1 = __importDefault(require("../prisma"));
const auth_middleware_1 = require("../middleware/auth.middleware");
const http_response_1 = require("../utils/http-response");
const push_service_1 = require("./push.service");
const router = express_1.default.Router();
const getUserId = (req, res) => {
    var _a;
    if (!((_a = req.user) === null || _a === void 0 ? void 0 : _a.id)) {
        (0, http_response_1.errorResponse)(res, "Authentication required", 401);
        return null;
    }
    try {
        return BigInt(req.user.id);
    }
    catch (_error) {
        (0, http_response_1.errorResponse)(res, "Invalid user identifier", 400);
        return null;
    }
};
router.get("/vapid-public-key", (_req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const publicKey = (0, push_service_1.getVapidPublicKey)();
    if (!publicKey) {
        return (0, http_response_1.errorResponse)(res, "Web Push is not configured on the server", 503);
    }
    return (0, http_response_1.successResponse)(res, { publicKey }, "VAPID public key retrieved successfully");
}));
router.use(auth_middleware_1.authenticateJWT);
router.post("/subscribe", (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const userId = getUserId(req, res);
    if (userId === null)
        return;
    const { endpoint, keys, userAgent } = req.body || {};
    if (!endpoint || !keys || !keys.p256dh || !keys.auth) {
        return (0, http_response_1.errorResponse)(res, "Invalid subscription payload. Expected endpoint, keys.p256dh, keys.auth", 400);
    }
    try {
        const existing = yield prisma_1.default.pushSubscription.findUnique({
            where: { endpoint },
        });
        let subscription;
        if (existing) {
            if (existing.user_id === userId) {
                subscription = yield prisma_1.default.pushSubscription.update({
                    where: { id: existing.id },
                    data: {
                        p256dh: keys.p256dh,
                        auth: keys.auth,
                        user_agent: userAgent || existing.user_agent,
                    },
                });
            }
            else {
                yield prisma_1.default.pushSubscription.update({
                    where: { id: existing.id },
                    data: { user_id: userId },
                });
                subscription = yield prisma_1.default.pushSubscription.findUnique({
                    where: { endpoint },
                });
            }
        }
        else {
            subscription = yield prisma_1.default.pushSubscription.create({
                data: {
                    user_id: userId,
                    endpoint,
                    p256dh: keys.p256dh,
                    auth: keys.auth,
                    user_agent: userAgent || null,
                },
            });
        }
        return (0, http_response_1.successResponse)(res, { subscription: { id: subscription.id.toString() } }, "Push subscription saved successfully", 201);
    }
    catch (error) {
        return (0, http_response_1.errorResponse)(res, "Failed to save push subscription", 500, error.message);
    }
}));
router.post("/unsubscribe", (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const userId = getUserId(req, res);
    if (userId === null)
        return;
    const { endpoint } = req.body || {};
    if (!endpoint) {
        return (0, http_response_1.errorResponse)(res, "endpoint is required", 400);
    }
    try {
        yield prisma_1.default.pushSubscription.deleteMany({
            where: { endpoint, user_id: userId },
        });
        return (0, http_response_1.successResponse)(res, [], "Push subscription removed successfully");
    }
    catch (error) {
        return (0, http_response_1.errorResponse)(res, "Failed to remove push subscription", 500, error.message);
    }
}));
exports.default = router;
