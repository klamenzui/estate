const Response = require('../models/response');
const Helper = require('../utils/helper');
const Error = require('./error');
const fs = require('fs');

class Page {
    tpl = 'index.ejs';
    access = false;
    controller = null;
    title = '';
    data = {};
    includes = {base: '/static/', imgpath: '/static/img/', bottom: {js: {}, css: {}}, top: {js: {}, css: {}}};
    addMethodToTpl = true;
    clazz;
    method;
    tplPath;

    constructor(controller) {
        this.controller = controller;
        this.access = controller.req.isAuthenticated();
        this.title = this.clazz = this.controller.clazz;
        this.includeCss('fonts', 'top');
        //this.includeCss('bootstrap.min', 'top');
        this.includeCss('sb-admin-2', 'top');
        //this.includeCss('bootstrap/scss/bootstrap', 'top');
        this.includeCss('lightboxed', 'top');


        this.includeJs('jquery.min', 'top');
        this.includeJs('bootstrap.bundle.min', 'bottom');
        //this.includeJs('jquery.easing.min','bottom');
        this.includeJs('sb-admin-2', 'bottom');
        //this.includeJs('jquery.tabledit', 'bottom');
        this.includeJs('lightboxed', 'bottom');
        this.includeJs('table', 'bottom');

    }

    index() {
        this.get();
    }

    get() {
        this.sendData({
            user: this.controller.req.user,
        });
    }

    includeJs(fname, place) {
        place = place ? place : 'top';
        this.includes[place].js[fname] = this.includes.base + 'js/' + fname + '.js';
        return this;
    }

    includeCss(fname, place) {
        place = place ? place : 'top';
        this.includes[place].css[fname] = this.includes.base + 'css/' + fname + '.css';
        return this;
    }

    isAuthenticated() {
        return true;//this.access;
    }

    isApi() {
        return this.controller.folder === "api";
    }

    initTpl() {
        this.tplPath = this.clazz;
        if (this.method !== 'index' && this.addMethodToTpl) {
            this.tplPath = this.clazz + '.' + this.method;
        }
        if (this.controller.folder !== 'pages') {
            this.tplPath = this.controller.folder + '/' + this.tplPath;
        }
        this.tplPath = this.tplPath + ".ejs";
        let isTplExists = fs.existsSync(this.controller.req.app.get('views') + this.tplPath);
        console.log(this.controller.req.app.get('views') + this.tplPath, isTplExists);
        return isTplExists;
    }

    getTitle() {
        return this.title? this.title: '';
    }

    sendData(results) {
        /*if (err) {
                    new Response(true, err.message, err));
                } else {
                    //get token and set into cookie
                    const obj = {
                        id: results.insertId,
                        data: data
                    }
                    res.status(200).json(new Response(false, "data created successfully", obj))
                }
                */
        if (results && Helper.isError(results)) {
            let num = 500;
            if (typeof results.num == 'number') {
                num = results.num;
            }
            this.data = new Response(num, results.message, results);
        } else {
            //TODO: remove typeof results[0][0] == 'undefined'
            results = (results && results[0] && results[0][0] ? results[0] : results);
            this.data = new Response(false, "", results);
            //res.status(200).json(new Response(false, "data created successfully", obj))
        }
        if (this.isApi()) {
            //this.controller.res.send(new Response(401, 'Unauthorized', {}));
            this.controller.res.json(this.data);
        } else {
            let isTplExists = this.initTpl();
            this.data['title'] = this.getTitle();
            this.data['tplPath'] = this.tplPath;
            this.data['page'] = this.clazz + '.' + this.method;
            this.data['includes'] = this.includes;
            if (!isTplExists) {
                this.data = new Response(404, {message: 'Not Found'});
                this.data['page'] = 'error';
            }
            this.controller.res.render(this.tpl, this.data);
        }
        return this;
    }

    execMethod() {
        if (this.isAuthenticated()) {
            let method = Helper.getMethod(this, this.controller.method);
            let isExists = !Helper.isEmpty(method);
            if (!isExists) {
                //this.controller.clazz = this.page = 'error';
                //method = '404';
                new Error(this.controller)['404']();
            } else {
                this.method = method;
                this[method]();
            }
        } else {
            if (this.isApi()) {
                //this['401']();
                new Error(this.controller)['401']();
            } else {
                this.controller.res.redirect('/auth/login');
            }
        }
    }
}

module.exports = Page