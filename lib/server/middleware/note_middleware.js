const { default: mongoose } = require("mongoose");
// Middleware to check the validity of ObjectId

const validateObjectId = (req, res, next) => {
    const { id } = req.params;
    // Check if the provided ID is valid
    if (!mongoose.Types.ObjectId.isValid(id)) {
        return res.status(400).json({ error: 'Invalid ID' });
    }

    // If the ID is valid, move on to the next middleware or route handler
    next();
};
module.exports = validateObjectId;