import express from "express";
import { getDataBase } from "../config/mongodb_client";
import { User } from "../models/user_model";
import bcrypt from "bcrypt";
import { ObjectId } from "mongodb";

export class UserController {

    static async signUp(request: express.Request, response: express.Response,) {

        let db = getDataBase();
        let usersCollection = db.collection("users");

        const user: User = request.body // this will get responce body and put it into one object so we cant send it and check it

        const checkUserInDb = {
            email: user.email
        }

        let data = await usersCollection.find(checkUserInDb).toArray();

        if (data.length != 0) {
            response.status(403).send(
                {
                    "status": "Failure",
                    "response": "Email already exists"
                }
            )
        } else {
            let salt = await bcrypt.genSalt(10);
            user.password = await bcrypt.hash(user.password, salt); // this will encrypt password 

            const responseData = await usersCollection.insertOne(user); // getting responce whatever it insert in database

            const objectId = responseData.insertedId;

            const userInfo = await usersCollection.find({ _id: new ObjectId(objectId) }).toArray() // here we are getting information againset object id of perticular user that we recently create

            const userResponseData = userInfo[0];

            userResponseData.password = "";

            response.status(200).send({
                "status": "success",
                "response": userResponseData
            })
        }

    }

    static async signIn(request: express.Request, response: express.Response) {
        debugger
        let db = getDataBase();

        let usersCollection = db.collection("users");

        const user: User = request.body;

        let checkUserInDb = {
            email: user.email
        }

        let data = await usersCollection.find(checkUserInDb).toArray();


        if (data.length != 0) {

            let userInfo = data[0];

            const pass = await bcrypt.compare(user.password, userInfo.password)

            if ((user.email == userInfo.email) && pass) {

                userInfo.password = "";

                response.status(200).json({
                    "status": "success",
                    "response": userInfo
                })

            } else {
                response.status(403).send(
                    {
                        "status": "Failure",
                        "response": "Invalid Email and Password please check"
                    }
                )

            }


        } else {
            response.status(403).send(
                {
                    "status": "Failure",
                    "response": "Invalid Email and Password please check"
                }
            )

        }


    }



    static async myProfile(request: express.Request, responce: express.Response) {
        let db = getDataBase();

        let usersCollection = db.collection("users");

        const uid = request.query.uid;

        const userData = await usersCollection.find({ _id: new ObjectId(uid!.toString()) }).toArray();

        responce.status(200).json({
            "status": "success",
            "response": userData[0]
        })
    }



    static async updateProfile(request: express.Request, response: express.Response) {

        let db = getDataBase();

        let usersCollection = db.collection("users");

        const user: User = request.body;

        const updateUser = {
            username: user.username,
        }

        const updateUserInfo = await usersCollection.updateOne({ _id: new ObjectId(user.uid) }, { $set: updateUser })

        response.status(200).json({
            "status": "success",
            "response": updateUserInfo
        })
    }






}