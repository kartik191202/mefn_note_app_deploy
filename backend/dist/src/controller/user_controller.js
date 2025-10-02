"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.UserController = void 0;
const mongodb_client_1 = require("../config/mongodb_client");
const bcrypt_1 = __importDefault(require("bcrypt"));
const mongodb_1 = require("mongodb");
class UserController {
    static async signUp(request, response) {
        let db = (0, mongodb_client_1.getDataBase)();
        let usersCollection = db.collection("users");
        const user = request.body; // this will get responce body and put it into one object so we cant send it and check it
        const checkUserInDb = {
            email: user.email
        };
        let data = await usersCollection.find(checkUserInDb).toArray();
        if (data.length != 0) {
            response.status(403).send({
                "status": "Failure",
                "response": "Email already exists"
            });
        }
        else {
            let salt = await bcrypt_1.default.genSalt(10);
            user.password = await bcrypt_1.default.hash(user.password, salt); // this will encrypt password 
            const responseData = await usersCollection.insertOne(user); // getting responce whatever it insert in database
            const objectId = responseData.insertedId;
            const userInfo = await usersCollection.find({ _id: new mongodb_1.ObjectId(objectId) }).toArray(); // here we are getting information againset object id of perticular user that we recently create
            const userResponseData = userInfo[0];
            userResponseData.password = "";
            response.status(200).send({
                "status": "success",
                "response": userResponseData
            });
        }
    }
    static async signIn(request, response) {
        debugger;
        let db = (0, mongodb_client_1.getDataBase)();
        let usersCollection = db.collection("users");
        const user = request.body;
        let checkUserInDb = {
            email: user.email
        };
        let data = await usersCollection.find(checkUserInDb).toArray();
        if (data.length != 0) {
            let userInfo = data[0];
            const pass = await bcrypt_1.default.compare(user.password, userInfo.password);
            if ((user.email == userInfo.email) && pass) {
                userInfo.password = "";
                response.status(200).json({
                    "status": "success",
                    "response": userInfo
                });
            }
            else {
                response.status(403).send({
                    "status": "Failure",
                    "response": "Invalid Email and Password please check"
                });
            }
        }
        else {
            response.status(403).send({
                "status": "Failure",
                "response": "Invalid Email and Password please check"
            });
        }
    }
    static async myProfile(request, responce) {
        let db = (0, mongodb_client_1.getDataBase)();
        let usersCollection = db.collection("users");
        const uid = request.query.uid;
        const userData = await usersCollection.find({ _id: new mongodb_1.ObjectId(uid.toString()) }).toArray();
        responce.status(200).json({
            "status": "success",
            "response": userData[0]
        });
    }
    static async updateProfile(request, response) {
        let db = (0, mongodb_client_1.getDataBase)();
        let usersCollection = db.collection("users");
        const user = request.body;
        const updateUser = {
            username: user.username,
        };
        const updateUserInfo = await usersCollection.updateOne({ _id: new mongodb_1.ObjectId(user.uid) }, { $set: updateUser });
        response.status(200).json({
            "status": "success",
            "response": updateUserInfo
        });
    }
}
exports.UserController = UserController;
