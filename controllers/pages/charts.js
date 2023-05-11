const Page = require("../Page");
class Home extends Page {
    constructor(controller) {
        super(controller);
        this.includeJs('chart.js/Chart.min', 'bottom');
        //<!-- Page level custom scripts -->
        this.includeJs('demo/chart-area-demo', 'bottom');
        this.includeJs('demo/chart-pie-demo', 'bottom');
        this.includeJs('demo/chart-bar-demo', 'bottom');
    }
}

module.exports = Home