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
exports.getUserOnboarding = exports.upsertOnboarding = void 0;
const prisma_1 = __importDefault(require("../prisma"));
const CACHE_TTL_MS = 15000;
const cache = new Map();
const cacheKey = (userId) => `onboarding:${userId.toString()}`;
const upsertOnboarding = (userId, data) => __awaiter(void 0, void 0, void 0, function* () {
    const onboarding = yield prisma_1.default.userOnboarding.upsert({
        where: { user_id: userId },
        create: {
            user_id: userId,
            income_source: data.income_source,
            annual_income: data.annual_income,
            employment_status: data.employment_status,
            investment_goal: data.investment_goal || null,
        },
        update: {
            income_source: data.income_source,
            annual_income: data.annual_income,
            employment_status: data.employment_status,
            investment_goal: data.investment_goal || null,
        },
    });
    cache.set(cacheKey(userId), { ts: Date.now(), value: onboarding });
    return onboarding;
});
exports.upsertOnboarding = upsertOnboarding;
const getUserOnboarding = (userId) => __awaiter(void 0, void 0, void 0, function* () {
    const key = cacheKey(userId);
    const hit = cache.get(key);
    if (hit && Date.now() - hit.ts < CACHE_TTL_MS) {
        return hit.value;
    }
    const onboarding = yield prisma_1.default.userOnboarding.findUnique({
        where: { user_id: userId },
    });
    if (onboarding) {
        cache.set(key, { ts: Date.now(), value: onboarding });
    }
    else {
        cache.delete(key);
    }
    return onboarding;
});
exports.getUserOnboarding = getUserOnboarding;
