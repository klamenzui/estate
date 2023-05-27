const Page = require('../page');
class Home extends Page {
    constructor(controller) {
        super(controller);
        this.includeJs('chart.js/Chart.min', 'bottom');
    }
    index() {
        this.sendData( {
            user : this.controller.req.user,
        });
    }

}

module.exports = Home