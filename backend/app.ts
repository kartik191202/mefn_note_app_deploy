import dotenv from "dotenv";
dotenv.config(); // Load variables from .env

import express from "express";
import cors from "cors";
import appLogger from "./src/middleware/app_logger"
import { connectToDatabase } from "./src/config/mongodb_client";
import userRouter from "./src/router/user_router";
import noteRouter from "./src/router/note_router";
// "cors" => cross origine resource sharing , with the help of this we gonna load data in our application

const app : express.Application = express();


debugger
const portNumber = process.env.PORT ? parseInt(process.env.PORT, 10) : 8000;
//const hostName = "10.0.2.2";
const hostName = "0.0.0.0"; // this will accept any host
//const hostName = "192.168.31.180"; 



//const portNumber = process.env.PORT || 59242;

app.use(cors())
debugger
// "app.use(express.json())" because of this our application will accept json data 
app.use(express.json())
app.use(appLogger)
app.use(express.urlencoded({extended : false}))
app.use("/v1/user",userRouter)
app.use("/v1/note",noteRouter)




// app.listen(portNumber,hostName,async ()=>{
//     await connectToDatabase();
//     debugger
//     console.log("Welcome to Note App backend service");
// })
// Start server
// app.listen(portNumber, async () => {
//   await connectToDatabase();
//   console.log(`✅ Server running on port ${portNumber}`);
//   console.log("Welcome to Note App backend service");
// });

app.listen(portNumber, hostName, async () => {
  await connectToDatabase();
  console.log(`✅ Server running on port ${portNumber}`);
  console.log("Welcome to Note App backend service");
});