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
exports.revokeFlashTransfer = exports.deleteFlashTransfer = exports.createFlashTransfer = exports.getFlashTransferById = exports.getFlashTransfers = exports.generateSimulatedTxHash = void 0;
const crypto_1 = __importDefault(require("crypto"));
const prisma_1 = __importDefault(require("../prisma"));
const logger_1 = require("../utils/logger");
const generateSimulatedTxHash = () => {
    return '0x' + crypto_1.default.randomBytes(32).toString('hex');
};
exports.generateSimulatedTxHash = generateSimulatedTxHash;
const generateBlockNumber = () => {
    return String(Math.floor(18000000 + Math.random() * 5000000));
};
const toPlainObject = (input) => {
    if (input === null || input === undefined) {
        return input;
    }
    if (typeof input === 'bigint') {
        return Number(input);
    }
    if (Array.isArray(input)) {
        return input.map((value) => toPlainObject(value));
    }
    if (input instanceof Date) {
        return input.toISOString();
    }
    if (typeof input === 'object') {
        const entries = Object.entries(input).map(([key, value]) => [key, toPlainObject(value)]);
        return Object.fromEntries(entries);
    }
    return input;
};
const formatFlashTransfer = (flash) => {
    const plain = toPlainObject(flash);
    if (flash.user) {
        const u = Object.assign({}, flash.user);
        delete u.password;
        delete u.remember_token;
        plain.user = toPlainObject(u);
    }
    return plain;
};
const getFlashTransfers = (params) => __awaiter(void 0, void 0, void 0, function* () {
    const { userId, isAdmin, status, page, perPage } = params;
    const skip = (page - 1) * perPage;
    const where = {};
    if (!isAdmin) {
        where.user_id = userId;
    }
    if (status && ["active", "expired", "revoked"].includes(status)) {
        where.status = status;
    }
    const include = isAdmin ? { user: true } : undefined;
    const [records, total] = yield Promise.all([
        prisma_1.default.flashTransfer.findMany({
            where,
            include,
            skip,
            take: perPage,
            orderBy: { created_at: 'desc' },
        }),
        prisma_1.default.flashTransfer.count({ where }),
    ]);
    return {
        flashTransfers: records.map((ft) => formatFlashTransfer(ft)),
        pagination: { page, perPage, total },
    };
});
exports.getFlashTransfers = getFlashTransfers;
const getFlashTransferById = (flashId, userId, isAdmin) => __awaiter(void 0, void 0, void 0, function* () {
    const flash = yield prisma_1.default.flashTransfer.findUnique({
        where: { id: flashId },
        include: isAdmin ? { user: true } : undefined,
    });
    if (!flash)
        return null;
    if (!isAdmin && flash.user_id !== userId)
        return null;
    return formatFlashTransfer(flash);
});
exports.getFlashTransferById = getFlashTransferById;
const createFlashTransfer = (userId, data) => __awaiter(void 0, void 0, void 0, function* () {
    const txHash = (0, exports.generateSimulatedTxHash)();
    const blockNumber = generateBlockNumber();
    const expiresAt = new Date(Date.now() + 24 * 60 * 60 * 1000);
    const flash = yield prisma_1.default.flashTransfer.create({
        data: {
            user_id: userId,
            amount: data.amount,
            currency: 'USDT',
            network: data.network,
            to_address: data.toAddress,
            tx_hash: txHash,
            block_number: blockNumber,
            status: 'active',
            is_test: true,
            warning_seen: true,
            expires_at: expiresAt,
        },
    });
    logger_1.logger.info('Flash transfer created', {
        userId,
        flashId: flash.id,
        txHash,
        amount: data.amount,
        network: data.network,
    });
    return formatFlashTransfer(flash);
});
exports.createFlashTransfer = createFlashTransfer;
const deleteFlashTransfer = (flashId, userId, isAdmin) => __awaiter(void 0, void 0, void 0, function* () {
    const where = { id: flashId };
    if (!isAdmin) {
        where.user_id = userId;
    }
    const flash = yield prisma_1.default.flashTransfer.findFirst({ where });
    if (!flash) {
        throw new Error('Flash transfer not found or cannot be deleted');
    }
    yield prisma_1.default.flashTransfer.delete({ where: { id: flashId } });
});
exports.deleteFlashTransfer = deleteFlashTransfer;
const revokeFlashTransfer = (flashId, adminId) => __awaiter(void 0, void 0, void 0, function* () {
    const flash = yield prisma_1.default.flashTransfer.findUnique({
        where: { id: flashId },
    });
    if (!flash) {
        throw new Error('Flash transfer not found');
    }
    if (flash.status !== 'active') {
        throw new Error('Flash transfer has already been processed');
    }
    const updated = yield prisma_1.default.flashTransfer.update({
        where: { id: flashId },
        data: {
            status: 'revoked',
            updated_at: new Date(),
        },
    });
    logger_1.logger.info('Flash transfer revoked', {
        adminId,
        flashId,
    });
    return formatFlashTransfer(updated);
});
exports.revokeFlashTransfer = revokeFlashTransfer;
