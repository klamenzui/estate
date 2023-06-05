const Page = require('../page');
class Auth extends Page{
    constructor(controller) {
        super(controller);
        this.tpl = 'base.ejs';
        this.access = true;
        this.title = this.constructor.name;
        this.roleAccess = {
            login:">-1",
            register:">-1",
            logout:">-1",
            'forgot-password':">-1",
        };
    }
    'login'() {
        let msg = this.controller.req.flash('loginMessage');
        this.sendData({
            stack: 'login',
            message: typeof msg === 'string'? msg: msg[0]
        });
    }

    register(){
        let msg = this.controller.req.flash('signupMessage');
        this.sendData( {
            stack: 'register',
            message: typeof msg === 'string'? msg: msg[0]
        });
    }

    logout(){
        this.controller.req.logout(function(){
            console.log('logout');
        });
        this.controller.res.redirect('/');
    }

    'forgot-password'(){
        let msg = this.controller.req.flash('loginMessage');
        this.sendData( {
            stack: 'forgot-password',
            message: typeof msg === 'string'? msg: msg[0]
        });
    }

}

module.exports = Auth