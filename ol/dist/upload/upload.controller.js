"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.uploadFile = void 0;
const blob_1 = require("@vercel/blob");
const http_response_1 = require("../utils/http-response");
const logger_1 = require("../utils/logger");
const uploadFile = async (req, res) => {
    try {
        if (!req.file) {
            return (0, http_response_1.errorResponse)(res, "No file provided", 400);
        }
        const { originalname, buffer } = req.file;
        // Generate a unique filename to prevent overwrites
        const uniqueFilename = `${Date.now()}-${Math.round(Math.random() * 1e9)}-${originalname}`;
        const blob = await (0, blob_1.put)(uniqueFilename, buffer, {
            access: "public",
        });
        return (0, http_response_1.successResponse)(res, { url: blob.url }, "File uploaded successfully", 201);
    }
    catch (error) {
        logger_1.logger.error("File upload failed", error);
        return (0, http_response_1.errorResponse)(res, "File upload failed", 500, error.message);
    }
};
exports.uploadFile = uploadFile;
