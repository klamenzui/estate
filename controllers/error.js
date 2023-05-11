const Page = require('./page');
class Error extends Page{
    constructor(controller) {
        super(controller);
        if(!this.isAuthenticated()){
            this.tpl = 'base.ejs';
        }
        this.page = 'error';
        this.access = true;
        this.title = 'Error';
    }
    '401'() {
        this.sendData({num: 401, message: 'Unauthorized'});
    }

    '404'() {
        this.sendData({num: 404, message: 'Not found'});
    }

    '500'() {
        this.sendData({num: 500, message: 'Server error'});
    }

}

module.exports = Error