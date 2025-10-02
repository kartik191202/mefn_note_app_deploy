"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = __importDefault(require("express"));
const note_controller_1 = require("../controller/note_controller");
const noteRouter = express_1.default.Router();
noteRouter.get("/getMyNotes", note_controller_1.NoteController.getMyNotes);
noteRouter.post("/addNote", note_controller_1.NoteController.addNote);
noteRouter.put("/updateNote", note_controller_1.NoteController.updateNote);
noteRouter.delete("/deleteNote", note_controller_1.NoteController.deleteNote);
exports.default = noteRouter;
