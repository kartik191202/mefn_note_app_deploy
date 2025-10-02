"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.NoteController = void 0;
const mongodb_client_1 = require("../config/mongodb_client");
const mongodb_1 = require("mongodb");
class NoteController {
    static async getMyNotes(request, response) {
        let db = (0, mongodb_client_1.getDataBase)();
        let notesCollection = db.collection("notes");
        const uid = request.query.uid;
        const notes = await notesCollection.find({ creatorId: uid }).toArray();
        response.status(200).json({
            "status": "success",
            "response": notes
        });
    }
    static async addNote(request, response) {
        let db = (0, mongodb_client_1.getDataBase)();
        let notesCollection = db.collection("notes");
        const note = request.body;
        const doc = {
            title: note.title,
            description: note.description,
            createdAt: Date.now(),
            creatorId: note.creatorId
        };
        const responseData = await notesCollection.insertOne(doc);
        response.status(200).json({
            "status": "success",
            "response": "Note added successfully"
        });
    }
    static async updateNote(request, response) {
        let db = (0, mongodb_client_1.getDataBase)();
        let notesCollection = db.collection("notes");
        const note = request.body;
        const updateNote = {
            title: note.title,
            description: note.description,
        };
        const updateResult = await notesCollection.updateOne({ _id: new mongodb_1.ObjectId(note.noteId) }, { $set: updateNote });
        response.status(200).json({
            "status": "success",
            "response": "Note updated successfully"
        });
    }
    static async deleteNote(request, response) {
        let db = (0, mongodb_client_1.getDataBase)();
        let notesCollection = db.collection("notes");
        const note = request.body;
        const deleteResult = await notesCollection.deleteOne({ _id: new mongodb_1.ObjectId(note.noteId) });
        response.status(200).json({
            "status": "success",
            "response": "Note deleted successfully"
        });
    }
}
exports.NoteController = NoteController;
