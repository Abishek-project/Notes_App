const mongoose = require("mongoose");

const noteSchema = new mongoose.Schema({
    title: {
        required: true,
        type: String
    },
    description: {
        required: true,
        type: String
    }
})
const notesModel = mongoose.model("notes", noteSchema);
module.exports = notesModel;