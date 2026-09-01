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
exports.revokeFlashTransfer = exports.deleteFlashTransfer = exports.createFlashTransfer = exports.getFlashTransfer = exports.listFlashTransfers = void 0;
const flash_transfer_service_1 = require("./flash-transfer.service");
const http_response_1 = require("../utils/http-response");
const prisma_1 = __importDefault(require("../prisma"));
const listFlashTransfers = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const isAdmin = req.user.role === 'admin';
        const page = Math.max(1, parseInt(req.query.page) || 1);
        const perPage = Math.min(100, Math.max(1, parseInt(req.query.per_page) || 15));
        const status = req.query.status;
        const result = yield (0, flash_transfer_service_1.getFlashTransfers)({
            userId: req.user.id,
            isAdmin,
            status,
            page,
            perPage,
        });
        return (0, http_response_1.successResponse)(res, result, isAdmin ? 'All flash transfers retrieved' : 'Your flash transfers retrieved');
    }
    catch (error) {
        return (0, http_response_1.errorResponse)(res, 'Failed to retrieve flash transfers', 500, error.message);
    }
});
exports.listFlashTransfers = listFlashTransfers;
const getFlashTransfer = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const flashId = BigInt(req.params.id);
        const isAdmin = req.user.role === 'admin';
        const flash = yield (0, flash_transfer_service_1.getFlashTransferById)(flashId, req.user.id, isAdmin);
        if (!flash) {
            return (0, http_response_1.errorResponse)(res, 'Flash transfer not found', 404);
        }
        return (0, http_response_1.successResponse)(res, { flash }, 'Flash transfer retrieved');
    }
    catch (error) {
        return (0, http_response_1.errorResponse)(res, 'Failed to retrieve flash transfer', 500, error.message);
    }
});
exports.getFlashTransfer = getFlashTransfer;
const createFlashTransfer = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const body = req.body;
        const amount = typeof body.amount === 'number' ? body.amount : Number(body.amount);
        const network = typeof body.network === 'string' ? body.network.trim().toUpperCase() : '';
        const toAddress = typeof body.toAddress === 'string' ? body.toAddress.trim() : '';
        const userId = BigInt(req.user.id);
        const flash = yield (0, flash_transfer_service_1.createFlashTransfer)(userId, {
            amount,
            network,
            toAddress,
        });
        return (0, http_response_1.successResponse)(res, { flash }, 'Flash transfer created successfully', 201);
    }
    catch (error) {
        return (0, http_response_1.errorResponse)(res, 'Failed to create flash transfer', 500, error.message);
    }
});
exports.createFlashTransfer = createFlashTransfer;
const deleteFlashTransfer = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const flashId = BigInt(req.params.id);
        const isAdmin = req.user.role === 'admin';
        yield (0, flash_transfer_service_1.deleteFlashTransfer)(flashId, req.user.id, isAdmin);
        return (0, http_response_1.successResponse)(res, [], 'Flash transfer deleted successfully');
    }
    catch (error) {
        const message = error.message;
        if (message === 'Flash transfer not found or cannot be deleted') {
            return (0, http_response_1.errorResponse)(res, message, 404);
        }
        return (0, http_response_1.errorResponse)(res, 'Failed to delete flash transfer', 500, message);
    }
});
exports.deleteFlashTransfer = deleteFlashTransfer;
const revokeFlashTransfer = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const flashId = BigInt(req.params.id);
        const user = yield prisma_1.default.user.findUnique({ where: { id: BigInt(req.user.id) } });
        if (!user || user.role !== 'admin') {
            return (0, http_response_1.errorResponse)(res, 'Unauthorized access', 403);
        }
        const flash = yield (0, flash_transfer_service_1.revokeFlashTransfer)(flashId, req.user.id);
        return (0, http_response_1.successResponse)(res, { flash }, 'Flash transfer revoked successfully');
    }
    catch (error) {
        const message = error.message;
        if (message === 'Flash transfer not found') {
            return (0, http_response_1.errorResponse)(res, message, 404);
        }
        if (message === 'Flash transfer has already been processed') {
            return (0, http_response_1.errorResponse)(res, message, 409);
        }
        return (0, http_response_1.errorResponse)(res, 'Failed to revoke flash transfer', 500, message);
    }
});
exports.revokeFlashTransfer = revokeFlashTransfer;
