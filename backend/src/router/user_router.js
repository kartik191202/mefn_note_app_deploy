"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = __importDefault(require("express"));
const user_controller_1 = require("../controller/user_controller");
const userRouter = express_1.default.Router();
debugger;
userRouter.post("/signUp", user_controller_1.UserController.signUp);
userRouter.post("/signIn", user_controller_1.UserController.signIn);
userRouter.get("/myProfile", user_controller_1.UserController.myProfile);
userRouter.put("/updateProfile", user_controller_1.UserController.updateProfile);
exports.default = userRouter;
