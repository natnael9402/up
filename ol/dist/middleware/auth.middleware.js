"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.authenticateOptionalJWT = exports.authenticateJWT = void 0;
const jsonwebtoken_1 = __importDefault(require("jsonwebtoken"));
const authenticateJWT = (req, res, next) => {
    const authHeader = req.headers.authorization;
    if (authHeader && process.env.JWT_SECRET) {
        const token = authHeader.split(" ")[1];
        jsonwebtoken_1.default.verify(token, process.env.JWT_SECRET, (err, user) => {
            if (err)
                return res.sendStatus(401);
            req.user = user;
            next();
        });
    }
    else {
        res.sendStatus(401);
    }
};
exports.authenticateJWT = authenticateJWT;
const authenticateOptionalJWT = (req, _res, next) => {
    const authHeader = req.headers.authorization;
    if (authHeader && process.env.JWT_SECRET) {
        const token = authHeader.split(" ")[1];
        jsonwebtoken_1.default.verify(token, process.env.JWT_SECRET, (err, user) => {
            if (!err && user)
                req.user = user;
            next();
        });
    }
    else {
        req.user = null;
        next();
    }
};
exports.authenticateOptionalJWT = authenticateOptionalJWT;
