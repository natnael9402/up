"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.OPTION_TRADE_RULES = void 0;
const logger_1 = require("./logger");
const DEFAULT_OPTION_TRADE_RULES = {
    30: { returnRate: 12, minAmount: 100, maxAmount: 15000 },
    60: { returnRate: 15, minAmount: 15000, maxAmount: 40000 },
    90: { returnRate: 18, minAmount: 40000, maxAmount: 80000 },
    180: { returnRate: 21, minAmount: 80000, maxAmount: 150000 },
    300: { returnRate: 24, minAmount: 150000, maxAmount: 400000 },
    450: { returnRate: 27, minAmount: 400000, maxAmount: 900000 },
};
function parseOptionTradeRules(rawRules, fallback) {
    if (!rawRules) {
        return fallback;
    }
    try {
        const parsed = JSON.parse(rawRules);
        if (typeof parsed !== "object" ||
            parsed === null ||
            Array.isArray(parsed)) {
            throw new Error("OPTION_TRADE_RULES must be a JSON object");
        }
        const normalized = Object.entries(parsed).reduce((acc, [durationKey, ruleValue]) => {
            const duration = Number(durationKey);
            if (!Number.isInteger(duration) || duration <= 0) {
                return acc;
            }
            if (!ruleValue ||
                typeof ruleValue !== "object" ||
                Array.isArray(ruleValue)) {
                return acc;
            }
            const { returnRate, minAmount, maxAmount, minCapital, maxCapital } = ruleValue;
            if (typeof returnRate !== "number") {
                return acc;
            }
            const effectiveMinAmount = typeof minAmount === "number" ? minAmount : minCapital;
            const effectiveMaxAmount = typeof maxAmount === "number" ? maxAmount : maxCapital;
            acc[duration] = Object.assign(Object.assign({ returnRate }, (typeof effectiveMinAmount === "number" ? { minAmount: effectiveMinAmount } : {})), (typeof effectiveMaxAmount === "number" ? { maxAmount: effectiveMaxAmount } : {}));
            return acc;
        }, {});
        if (Object.keys(normalized).length === 0) {
            throw new Error("No valid option trade rules found");
        }
        return normalized;
    }
    catch (error) {
        logger_1.logger.warn("Invalid OPTION_TRADE_RULES value. Using default rules.", {
            error: error instanceof Error ? error.message : error,
        });
        return fallback;
    }
}
exports.OPTION_TRADE_RULES = parseOptionTradeRules(process.env.OPTION_TRADE_RULES, DEFAULT_OPTION_TRADE_RULES);
