"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
// this  will call in between response and request 
let applogger = (request, response, next) => {
    debugger;
    const url = request.url;
    const method = request.method;
    const date = new Date().toLocaleDateString();
    const time = new Date().toLocaleTimeString();
    const result = `${url} | ${method} | ${date} | ${time}`;
    console.log(result);
    next();
};
exports.default = applogger;
