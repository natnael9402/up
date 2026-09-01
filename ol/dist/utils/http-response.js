"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.successResponse = successResponse;
exports.errorResponse = errorResponse;
const logger_1 = require("./logger");
const getRequestContext = (res) => {
    const req = res.req;
    if (!req)
        return {};
    return {
        method: req.method,
        path: req.originalUrl,
        userId: req.user?.id ?? null,
    };
};
function successResponse(res, data, message = "Operation successful", statusCode = 200) {
    const payload = { status: "success", message, data };
    logger_1.logger.info("Success response sent", {
        statusCode,
        message,
        hasData: data !== undefined,
        ...getRequestContext(res),
    });
    return res.status(statusCode).json(payload);
}
function errorResponse(res, message = "Operation failed", statusCode = 400, errors) {
    const payload = { status: "error", message, ...(errors ? { errors } : {}) };
    logger_1.logger.error("Error response sent", {
        statusCode,
        message,
        hasErrors: Boolean(errors),
        errorDetail: typeof errors === "string" ? errors : undefined,
        ...getRequestContext(res),
    });
    return res.status(statusCode).json(payload);
}
