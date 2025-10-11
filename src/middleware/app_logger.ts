import express from "express";

// this  will call in between response and request 
let applogger = (request : express.Request,response : express.Response,next: express.NextFunction)=>{
    debugger
    const url  = request.url;
    const method = request.method
    const date = new Date().toLocaleDateString();
    const time = new Date().toLocaleTimeString();

    const  result : string =  `${url} | ${method} | ${date} | ${time}`
    console.log(result) 

    next();
}
 
export default applogger;