const Helper = require('../../utils/helper');
const Page = require('../page');
const moment = require('moment');
const Loader = require('../../models/loader');

class Window extends Page {
    res;

    constructor(controller) {
        super(controller);
        let req = this.controller.req;
        this.tpl = 'part.ejs';
        this.addMethodToTpl = false;
        this.res = {
            header: {
                title: ''
            },
            body: {
                readonly: !!req.body.readonly,
                attr: {
                    'callback': req.body.callback,
                    'action': req.body.action,
                    'baseurl': ''
                },
                fields: {},
                data: {}
            },
            footer: {
                html: [
                    {
                        tag: 'button',
                        attr: {
                            class: "btn btn-secondary",
                            type: "button",
                            'data-dismiss': "modal"
                        },
                        html: "Cancel"
                    },
                    {
                        tag: 'a',
                        attr: {
                            href: '#',
                            class: "btn btn-primary",
                            onclick: 'processModal();'
                        },
                        html: 'Submit'
                    }
                ]
            }
        }
        let method = this.controller.method;
        let isAllow = (app.locals.config.gui.router['api'] && app.locals.config.gui.router['api'].indexOf(method) > -1);
        if(isAllow){
            this[method] = function(){
                this._sendData(method);
            }
        }
    }

    utilitymeter_current() {
        try {
            this.setAccess("<1");
            let req = this.controller.req;
            this._sendDataFrom('utilitymeter', req.body.data);
        }catch (e) {
            console.log(e);
        }
    }

    async logout() {
        this.setAccess(">-1");
        this.res.header.title = 'Ready to Leave?';
        this.res.body = 'Select "Logout" below if you are ready to end your current session.';
        this.res.footer.html[1].text = 'Logout';
        this.res.footer.html[1].attr.href = '/logout';
        this.sendData(await this._buildHtml());
    }

    _initData(clazz) {
        const entity = require('../../models/db/tables/'+clazz);
        this.res.header.title = clazz;
        this.res.body.attr.baseurl = '/api/' + clazz + '/';
        this.res.body.fields = {}
        this.res.body.data = {};
        return entity;
    }

     async _sendDataFrom(clazz, arr) {
         const entity = this._initData(clazz);
         for (let k in arr) {
             if(entity._fields[k]){
                 this.res.body.fields[k] = entity._fields[k];
                 this.res.body.data[k] = arr[k];
             }
         }
         await this.sendData(await this._buildHtml());
     }

    async _sendData(clazz) {
        let req = this.controller.req;
        const entity = this._initData(clazz);
        this.res.body.fields = entity._fields;
        if (req.query && !Helper.isEmpty(req.body.data[entity._primary_key])) {
            let results = await Loader.model(clazz).get(req.body.data[entity._primary_key]);
            if (!Helper.isEmpty(results.rows)) {
                this.res.body.data = results.rows[0];
            }
        } else {
            for (let k in entity._fields) {
                let field = entity._fields[k];
                if (typeof req.body.data[k] !== 'undefined') {
                    this.res.body.data[k] = req.body.data[k];
                }
                if (Helper.isEmpty(this.res.body.data[k]) && !Helper.isEmpty(field.default)) {
                    this.res.body.data[k] = field.default;
                    this.res.body.data[k] = (this.res.body.data[k] + '')
                        .replace('CURRENT_TIMESTAMP', moment(new Date()).format('YYYY-MM-DD'));
                }
            }
        }
        this.sendData(await this._buildHtml());

    }

    async _buildHtml() {
        for (let k in this.res) {
            let block = this.res[k];
            if (typeof block.fields !== 'undefined') {
                block.html = [];
                for (let f in block.fields) {
                    let field = block.fields[f];
                    let data = block.data && block.data[f] ? block.data[f] : '';
                    let type = field.type;
                    let combo_data = [];
                    let isDepTable = false;
                    let div = {
                        tag: 'div',
                        attr: {
                            class: "form-group"
                        },
                        html: [{
                            tag: 'label',
                            attr: {
                                for: field.name
                            },
                            html: field.name
                        }]
                    }
                    let input = {
                        tag: 'input',
                        attr: {
                            class: "form-control",
                            name: field.name
                        }
                    }
                    if (block.readonly) {
                        input.attr['disabled'] = "true";
                    }

                    if (Array.isArray(field.type)) {
                        type = field.type[0];
                    } else if (typeof field.type == 'object') {
                        type = 'object';
                        combo_data = field.type;
                    }
                    if (type === 'int' && field.name.endsWith('_id')) {
                        try {
                            let table_id = field.name.split('_');
                            const entity = require('../../models/db/tables/' + table_id[0]);
                            if (entity.description) {
                                let dep = await Loader.model(table_id[0]).select(entity.id, entity.description).exec();
                                if(dep.rows){
                                    combo_data = dep.rows;
                                    type = 'object';
                                    isDepTable = true;
                                }
                            }
                        } catch (ignore) {
                        }
                    }
                    if (field.key === 'PRI') {
                        type = 'hidden';
                    }
                    switch (type) {
                        case 'hidden':
                            input.attr['type'] = "hidden";
                            input.attr['value'] = data;
                            block.html.push(input);
                            break;
                        case 'text':
                            input.tag = 'textarea';
                            input.attr['rows'] = "3";
                            input.attr['placeholder'] = field.name;
                            input.html = data;
                            div.html.push(input);
                            block.html.push(div);
                            break;
                        case "object":
                            input.tag = 'select';
                            input.html = '';
                            let options = [];
                            // enum or dependency table
                            for (let o in combo_data) {
                                let selected = '';
                                let key = '';
                                let val = '';
                                let text = '';
                                if(isDepTable){
                                    key = combo_data[o].id;
                                    val = `value="${key}"`;
                                    text = combo_data[o].description;
                                }else{
                                    key = text = combo_data[o];
                                }
                                if (key == data || key == field.default) {
                                    selected = ' selected="selected"';
                                }
                                options.push(`<option${selected} ${val}>${text}</option>`);
                            }
                            input.html = options.join('');
                            div.html.push(input);
                            block.html.push(div);
                            break;
                        case "date":
                        case "datetime":
                        case "timestamp":
                            let format = 'Y-M-D';
                            input.attr['type'] = "date";
                            if (field.type !== "date") {
                                input.attr['type'] = "datetime-local";
                                format = 'Y-M-DTh:m:s';
                            }
                            if (!data instanceof Date) {
                                data = moment(data);
                            }
                            data = Helper.formatDate(data, format);
                            input.attr['value'] = data;
                            div.html.push(input);
                            block.html.push(div);
                            break;
                        default:
                            input.attr['type'] = 'text';
                            input.attr['placeholder'] = field.name;
                            input.attr['value'] = data;
                            div.html.push(input);
                            block.html.push(div);
                    }

                }
            }

            if (block.html) {
                block.html = Helper.getHtml(this.res[k].html);
            }

            if (block.attr) {
                block.attr = Helper.getTag(this.res[k]);
            }
        }
        return this.res;
    }
}

module.exports = Window