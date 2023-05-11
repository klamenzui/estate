const Page = require("../Page");
class Auth extends Page{
    constructor(controller) {
        super(controller);
        this.tpl = 'base.ejs';
        this.access = true;
        this.title = this.constructor.name;
    }
    'login'() {
        this.sendData({
            message: this.controller.req.flash('loginMessage')
        });
    }

    register(){
        this.sendData( {
            message: this.controller.req.flash('signupMessage')
        });
    }

    logout(){
        this.controller.req.logout(function(){
            console.log('logout');
        });
        this.controller.res.redirect('/');
    }

    'forgot-password'(){
        this.sendData( {
            message: this.controller.req.flash('signupMessage')
        });
    }

}

module.exports = Auth