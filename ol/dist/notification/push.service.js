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
exports.getVapidPublicKey = exports.sendPushNotification = void 0;
const web_push_1 = __importDefault(require("web-push"));
const logger_1 = require("../utils/logger");
const vapidPublicKey = process.env.VAPID_PUBLIC_KEY || "";
const vapidPrivateKey = process.env.VAPID_PRIVATE_KEY || "";
const vapidSubject = process.env.VAPID_SUBJECT || "mailto:support@upholdtrade.com";
if (vapidPublicKey && vapidPrivateKey) {
    web_push_1.default.setVapidDetails(vapidSubject, vapidPublicKey, vapidPrivateKey);
}
else {
    logger_1.logger.warn("VAPID keys not configured. Web Push notifications disabled.");
}
const getVapidPublicKey = () => vapidPublicKey;
exports.getVapidPublicKey = getVapidPublicKey;
const sendPushNotification = (subscription, notification) => __awaiter(void 0, void 0, void 0, function* () {
    if (!vapidPublicKey || !vapidPrivateKey) {
        return { success: false, statusCode: 0, error: "VAPID not configured" };
    }
    const payload = JSON.stringify({
        title: notification.title,
        body: notification.message,
        icon: notification.imageUrl || undefined,
        data: { url: "/apps/live-chat" },
    });
    try {
        yield web_push_1.default.sendNotification({
            endpoint: subscription.endpoint,
            keys: {
                p256dh: subscription.p256dh,
                auth: subscription.auth,
            },
        }, payload);
        return { success: true };
    }
    catch (error) {
        const statusCode = error.statusCode || 0;
        logger_1.logger.warn(`Push send failed (statusCode=${statusCode})`, { endpoint: subscription.endpoint });
        return { success: false, statusCode, error: error.message };
    }
});
exports.sendPushNotification = sendPushNotification;
