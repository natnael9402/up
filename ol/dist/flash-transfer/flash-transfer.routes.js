"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = __importDefault(require("express"));
const flash_transfer_controller_1 = require("./flash-transfer.controller");
const auth_middleware_1 = require("../middleware/auth.middleware");
const admin_middleware_1 = require("../middleware/admin.middleware");
const validation_middleware_1 = require("../middleware/validation.middleware");
const flash_transfer_validation_1 = require("./flash-transfer.validation");
const router = express_1.default.Router();
/**
 * @swagger
 * tags:
 *   - name: FlashTransfers
 *     description: Simulated USDT flash transfers (TEST ONLY)
 */
router.use(auth_middleware_1.authenticateJWT);
/**
 * @swagger
 * /api/flash-transfers:
 *   get:
 *     summary: List flash transfers
 *     tags: [FlashTransfers]
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: query
 *         name: status
 *         schema:
 *           type: string
 *           enum: [active, expired, revoked]
 *       - in: query
 *         name: page
 *         schema:
 *           type: integer
 *       - in: query
 *         name: per_page
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: List of flash transfers
 */
router.get("/", (req, res) => (0, flash_transfer_controller_1.listFlashTransfers)(req, res));
/**
 * @swagger
 * /api/flash-transfers:
 *   post:
 *     summary: Create a flash transfer
 *     tags: [FlashTransfers]
 *     security:
 *       - bearerAuth: []
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - amount
 *               - network
 *               - toAddress
 *               - warningAcknowledged
 *             properties:
 *               amount:
 *                 type: number
 *               network:
 *                 type: string
 *                 enum: [TRC20, ERC20, BEP20]
 *               toAddress:
 *                 type: string
 *               warningAcknowledged:
 *                 type: boolean
 *     responses:
 *       201:
 *         description: Flash transfer created
 */
router.post("/", flash_transfer_validation_1.createFlashTransferValidator, validation_middleware_1.validationMiddleware, (req, res) => (0, flash_transfer_controller_1.createFlashTransfer)(req, res));
/**
 * @swagger
 * /api/flash-transfers/{id}:
 *   get:
 *     summary: Get a flash transfer
 *     tags: [FlashTransfers]
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Flash transfer details
 */
router.get("/:id", (req, res) => (0, flash_transfer_controller_1.getFlashTransfer)(req, res));
/**
 * @swagger
 * /api/flash-transfers/{id}:
 *   delete:
 *     summary: Delete a flash transfer
 *     tags: [FlashTransfers]
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Flash transfer deleted
 */
router.delete("/:id", (req, res) => (0, flash_transfer_controller_1.deleteFlashTransfer)(req, res));
/**
 * @swagger
 * /api/flash-transfers/{id}/revoke:
 *   patch:
 *     summary: Revoke a flash transfer (admin only)
 *     tags: [FlashTransfers]
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Flash transfer revoked
 */
router.patch("/:id/revoke", admin_middleware_1.authorizeAdmin, (req, res) => (0, flash_transfer_controller_1.revokeFlashTransfer)(req, res));
exports.default = router;
