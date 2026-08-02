"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.serializeBigInt = serializeBigInt;
function serializeBigInt(obj) {
    if (obj === null || obj === undefined || typeof obj === "string" || typeof obj === "number" || typeof obj === "boolean") {
        return obj;
    }
    if (typeof obj === "bigint") {
        const num = Number(obj);
        return Number.isSafeInteger(num) ? num : obj.toString();
    }
    if (typeof obj === "function" || typeof obj === "symbol") {
        return undefined;
    }
    if (Array.isArray(obj)) {
        return obj.map(serializeBigInt);
    }
    if (obj instanceof Date) {
        return obj.toISOString();
    }
    if (typeof obj === "object") {
        const result = {};
        for (const key of Object.keys(obj)) {
            const value = serializeBigInt(obj[key]);
            if (value !== undefined) {
                result[key] = value;
            }
        }
        return result;
    }
    return obj;
}
