const mongoose = require('mongoose');

const eventSchema = mongoose.Schema({
    eventName: {
        type: String,
        required: true
    },
    eventDescription: {
        type: String,
        required: true
    },
    eventAmount: {
        type: Number,
        required: true
    },
    eventImage: {
        type: String,
        required: true
    },
    eventCategory: {
        type: String,
        required: true,

    },
    eventPublishedOn: {
        type: Date,
        required: true
    },
    eventNoOfParticipants: {
        type: Number,
        required: true
    },
    eventLink: {
        type: String,
        required: true
    },
    eventContactPerson: {
        type: String,
        required: true
    },
    eventContactPersonNo: {
        type: Number,
        required: true
    },
    eventRegistrationDeadline: {
        type: String,
        required: true
    },
    eventPublishedBy: {
        type: String,
    }
})

const Event = mongoose.model('Events', eventSchema);
module.exports = Event;