"use strict";
// import { MongoClient } from 'mongodb';
Object.defineProperty(exports, "__esModule", { value: true });
exports.connectToDatabase = connectToDatabase;
exports.getDataBase = getDataBase;
// const uri = process.env.MONGODB_URI || 'mongodb://localhost:27017';
// const client = new MongoClient(uri);
// export async function getDataBase(dbName: string) {
//   await client.connect();
//   return client.db(dbName);
// }
const mongodb_1 = require("mongodb");
let mongoDb;
async function connectToDatabase() {
    //     const url = "mongodb://localhost:27017";    
    //   when you copy from mongo it will give you this url but 
    //   we need to change this from ip address because name will not work here
    const url = "mongodb://127.0.0.1:27017";
    const client = new mongodb_1.MongoClient(url);
    mongoDb = client.db("notedb");
    console.log("MongoDB database connect successfully");
}
function getDataBase() {
    return mongoDb;
}
