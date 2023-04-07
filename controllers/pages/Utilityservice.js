const Page = require("../Page");
class Utilityservice extends Page {
    constructor(controller) {
        super(controller);
    }

    index() {
        get();
    }
}

module.exports = Utilityservice