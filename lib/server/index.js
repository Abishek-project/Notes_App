const express = require("express");
const { default: mongoose } = require("mongoose");
const notesRouter = require("./routes/create_note");
const app = express();
const PORT = process.env.PORT || 3000;
const DB = "mongodb+srv://abishekabi992:7339174247@cluster0.tmqop4c.mongodb.net/?retryWrites=true&w=majority"
app.use(express.json());
app.use(notesRouter);

mongoose.connect(DB).then(() => {
    console.log("DB conneted")
}).catch((e) => {
    console.log(e);
})


app.listen(PORT, () => {
    console.log("Successfully connected" + PORT);
})
