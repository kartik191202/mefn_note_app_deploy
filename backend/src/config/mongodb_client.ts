// import { MongoClient } from 'mongodb';

// const uri = process.env.MONGODB_URI || 'mongodb://localhost:27017';
// const client = new MongoClient(uri);

// export async function getDataBase(dbName: string) {
//   await client.connect();
//   return client.db(dbName);
// }




import { MongoClient,Db } from "mongodb";

let mongoDb : Db

export async function connectToDatabase(){
//     const url = "mongodb://localhost:27017";    
//   when you copy from mongo it will give you this url but 
//   we need to change this from ip address because name will not work here
  const url = "mongodb://127.0.0.1:27017";
  const client  = new MongoClient(url);
  mongoDb = client.db("notedb")
  console.log("MongoDB database connect successfully")
}

export function getDataBase(){
    return mongoDb
}