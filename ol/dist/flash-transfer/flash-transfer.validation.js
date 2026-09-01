"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.createFlashTransferValidator = void 0;
const express_validator_1 = require("express-validator");
exports.createFlashTransferValidator = [
    (0, express_validator_1.body)("amount")
        .isFloat({ gt: 0 })
        .withMessage("Amount must be a positive number."),
    (0, express_validator_1.body)("network")
        .isIn(["TRC20", "ERC20", "BEP20"])
        .withMessage("Network must be one of: TRC20, ERC20, BEP20."),
    (0, express_validator_1.body)("toAddress")
        .isString()
        .trim()
        .notEmpty()
        .withMessage("Recipient address is required."),
    (0, express_validator_1.body)("warningAcknowledged")
        .isBoolean()
        .custom((value) => value === true)
        .withMessage("You must acknowledge the test-only warning."),
];
