module.exports.init = function (_controller) {
    const Page = require('../page');
    class Tpl extends Page {
        constructor(controller) {
            super(controller);
            //this.tpl = 'tpl.get.ejs';
            this.table = this.controller.clazz;
            this.clazz = 'tpl';
            this.method = 'get';
            //this.title = '' + controller.clazz;
        }
    }
    return new Tpl(_controller);
}