import express from "express";
import { getDataBase } from "../config/mongodb_client";
import { Note } from "../models/note_model";
import { ObjectId } from "mongodb";

export class NoteController {

    static async getMyNotes(request: express.Request, response: express.Response) {
        let db = getDataBase();
        let notesCollection = db.collection("notes");

        const uid = request.query.uid;

        const notes = await notesCollection.find({ creatorId: uid }).toArray();

        response.status(200).json({
            "status": "success",
            "response": notes
        });
    }

    static async addNote(request: express.Request, response: express.Response) {
        let db = getDataBase();
        let notesCollection = db.collection("notes");

        const note: Note = request.body;
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

    static async updateNote(request: express.Request, response: express.Response) {
        let db = getDataBase();
        let notesCollection = db.collection("notes");

        const note: Note = request.body;

        const updateNote = {
            title: note.title,
            description: note.description,
        };

        const updateResult = await notesCollection.updateOne({ _id: new ObjectId(note.noteId!) }, { $set: updateNote });

        response.status(200).json({
            "status": "success",
            "response": "Note updated successfully"
        });
    }

    static async deleteNote(request: express.Request, response: express.Response) {
        let db = getDataBase();
        let notesCollection = db.collection("notes");

        const note: Note = request.body;

        const deleteResult = await notesCollection.deleteOne({ _id: new ObjectId(note.noteId!) });

        response.status(200).json({
            "status": "success",
            "response": "Note deleted successfully"
        });
    }
}
