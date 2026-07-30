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
exports.authorizeAdmin = void 0;
const http_response_1 = require("../utils/http-response");
const prisma_1 = __importDefault(require("../prisma"));
const authorizeAdmin = (req, res, next) => __awaiter(void 0, void 0, void 0, function* () {
    var _a;
    const userId = (_a = req.user) === null || _a === void 0 ? void 0 : _a.id;
    if (!userId) {
        return (0, http_response_1.errorResponse)(res, "Authentication required", 401);
    }
    try {
        const user = yield prisma_1.default.user.findUnique({
            where: { id: BigInt(userId) },
            select: { role: true },
        });
        if (user && user.role === "admin") {
            return next();
        }
    }
    catch (_b) { }
    return (0, http_response_1.errorResponse)(res, "Unauthorized access", 403);
});
exports.authorizeAdmin = authorizeAdmin;
