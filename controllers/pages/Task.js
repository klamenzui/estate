const Page = require("../Page");
class Task extends Page {
    constructor(controller) {
        super(controller);
    }

    index() {
        get();
    }
}

module.exports = Task