"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const dotenv_1 = __importDefault(require("dotenv"));
const path_1 = __importDefault(require("path"));
dotenv_1.default.config({ path: path_1.default.resolve(__dirname, "../.env") });
const express_1 = __importDefault(require("express"));
const cors_1 = __importDefault(require("cors"));
const mongoose_1 = __importDefault(require("mongoose"));
const app_logger_1 = __importDefault(require("./src/middleware/app_logger"));
const mongodb_client_1 = require("./src/config/mongodb_client");
const user_router_1 = __importDefault(require("./src/router/user_router"));
const note_router_1 = __importDefault(require("./src/router/note_router"));
// "cors" => cross origine resource sharing , with the help of this we gonna load data in our application
const app = (0, express_1.default)();
debugger;
//const hostName = "10.0.2.2";
const hostName = "0.0.0.0"; // this will accept any host
//const hostName = "192.168.31.180"; 
const portNumber = 8000;
//const portNumber = process.env.PORT || 59242;
const MONGO_URI = process.env.DB_URI;
if (!MONGO_URI) {
    throw new Error("DB_URI environment variable is not defined.");
}
mongoose_1.default.connect(MONGO_URI);
app.use((0, cors_1.default)());
debugger;
// "app.use(express.json())" because of this our application will accept json data 
app.use(express_1.default.json());
app.use(app_logger_1.default);
app.use(express_1.default.urlencoded({ extended: false }));
app.use("/v1/user", user_router_1.default);
app.use("/v1/note", note_router_1.default);
app.listen(portNumber, hostName, async () => {
    await (0, mongodb_client_1.connectToDatabase)();
    debugger;
    console.log("Welcome to Note App backend service");
});
