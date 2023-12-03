const express = require("express");
const noteRouter = express.Router();
const notesModel = require("../models/note");
const createError = require('http-errors');
const validateObjectId = require("../middleware/note_middleware");
noteRouter.post("/create-note", async (req, res) => {
    try {
        // Validation
        const { title, description } = req.body;
        if (!title || !description) {
            throw createError(400, 'Title and description are required');
        }

        // Create a new note
        const note = new notesModel({
            title,
            description
        });

        // Save the note to the database
        await note.save();

        // Respond with success
        return res.status(200).json({
            message: 'Note created successfully',
            note: { title, description }
        });
    } catch (error) {
        // Log the error for debugging purposes
        console.error(error);

        // Respond with an error
        if (createError.isHttpError(error)) {
            // If it's a known HTTP error, use its status code and message
            return res.status(error.statusCode).json({ error: error.message });
        } else {
            // If it's an unknown error, respond with a generic 500 status
            return res.status(500).json({ error: 'Internal Server Error' });
        }
    }
});

noteRouter.get("/get-all-notes", async (req, res) => {
    try {
        const allNotes = await notesModel.find();
        return res.status(200).json({
            success: true,
            data: allNotes
        })
    } catch (error) {
        // Respond with an error
        if (createError.isHttpError(error)) {
            // If it's a known HTTP error, use its status code and message
            return res.status(error.statusCode).json({ error: error.message });
        } else {
            // If it's an unknown error, respond with a generic 500 status
            return res.status(500).json({ error: 'Internal Server Error' });
        }
    }


});

noteRouter.delete("/delete-note/:id", validateObjectId, async (req, res) => {
    try {
        const { id } = req.params;
        console.log(id);

        // Use findOneAndDelete to get the deleted document
        const deletedNote = await notesModel.findOneAndDelete({ _id: id });
        console.log(deletedNote);
        if (!deletedNote) {
            return res.status(404).json({ error: 'Note not found' });
        }
        return res.json(deletedNote);
    } catch (error) {
        // Respond with an error
        if (createError.isHttpError(error)) {
            // If it's a known HTTP error, use its status code and message
            return res.status(error.statusCode).json({ error: error.message });
        } else {
            // If it's an unknown error, respond with a generic 500 status
            return res.status(500).json({ error: 'Internal Server Error' });
        }
    }

});

noteRouter.put("/update-note/:id", validateObjectId, async (req, res) => {
    try {
        const { id } = req.params;
        const { title, description } = req.body;
        const updatedNote = await notesModel.findByIdAndUpdate(id,
            { title, description },
            { new: true });
        if (!updatedNote) {
            return res.status(404).json({ error: 'Note not found' });
        }

        return res.json(updatedNote);
    } catch (error) {
        // Respond with an error
        if (createError.isHttpError(error)) {
            // If it's a known HTTP error, use its status code and message
            return res.status(error.statusCode).json({ error: error.message });
        } else {
            // If it's an unknown error, respond with a generic 500 status
            return res.status(500).json({ error: 'Internal Server Error' });
        }
    }
})
module.exports = noteRouter;