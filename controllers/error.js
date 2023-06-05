class Error {
    page;
    constructor(page) {
        this.init(page);
    }
    init(page){
        if(page){
            this.page = page;
            if(!this.page.isAuthenticated()){
                this.page.tpl = 'base.ejs';
            }
            this.page.page = 'error';
            this.page.access = true;
            this.page.title = 'Error';
            this.page.sidebar = this.page.sidebar || {};
            this.page.includes = this.page.includes || {base: '/static/', imgpath: '/static/img/', bottom: {js: {}, css: {}}, top: {js: {}, css: {}}};
            if(!this.page.initTpl()){
                this.page.tplPath = 'error.ejs';
            }
        }
        return this;
    }
    '401'(msg) {
        this.render({num: 401, message: msg||'Unauthorized'});
    }

    '404'(msg) {
        this.render({num: 404, message: msg||'Not found'});
    }

    '500'(msg) {
        this.render({num: 500, message: msg||'Server error'});
    }
    render(data){
        if(this.page){
            if(this.page.isApi()){
                this.page.controller.res.json(data);
            }else{
                this.page['num'] = data.num;
                this.page['message'] = data.message;
                this.page.controller.res.render(this.page.tpl, this.page);
            }
        }
    }
}

module.exports = Error