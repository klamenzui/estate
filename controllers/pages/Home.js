const Page = require('../page');
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