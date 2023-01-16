const Page = require("../Page");
class Home extends Page {
    constructor(controller) {
        super(controller);
    }
    index() {
        this.sendData( {
            user : this.controller.req.user,
        });
    }

}

module.exports = Home