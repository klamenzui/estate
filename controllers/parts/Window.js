const Helper = require("../../utils/Helper");
const Page = require('../Page');
const moment = require('moment');

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
    }

    payment() {
        this._sendData('payment');
    }

    expense() {
        this._sendData('expense');
    }

    contract() {
        this._sendData('contract');
    }

    client() {
        this._sendData('client');
    }

    task() {
        this._sendData('task');
    }

    utilityservice() {
        this._sendData('utilityservice');
    }

    logout() {
        this.res.header.title = 'Ready to Leave?';
        this.res.body = 'Select "Logout" below if you are ready to end your current session.';
        this.res.footer.html[1].text = 'Logout';
        this.res.footer.html[1].attr.href = '/logout';
        this.sendData(this._buildHtml());
    }

    async _sendData(clazz) {
        let req = this.controller.req;
        const entity = require('../../models/db/tables/' + clazz);
        const Model = require('../../models/' + clazz);
        this.res.header.title = clazz;
        this.res.body.attr.baseurl = '/api/' + clazz + '/';
        this.res.body.fields = entity._fields;
        this.res.body.data = {};
        if (req.query && !Helper.isEmpty(req.body.data[entity._primary_key])) {
            let results = await new Model().get(req.body.data[entity._primary_key]);
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
        this.sendData(this._buildHtml());

    }

    _buildHtml() {
        for (let k in this.res) {
            let block = this.res[k];
            if (typeof block.fields !== 'undefined') {
                block.html = [];
                for(let f in block.fields){
                    let field = block.fields[f];
                    let data = block.data && block.data[f]?block.data[f]:'';
                    let type = field.type;
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
                            class:"form-control",
                            name:field.name
                        }
                    }
                    if(block.readonly){
                        input.attr['disabled']="true";
                    }

                    if(Array.isArray(field.type)){
                        type = field.type[0];
                    } else if(typeof field.type == 'object'){
                        type = 'object';
                    }
                    if(field.key === 'PRI'){
                        type = 'hidden';
                    }
                    switch(type){
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
                            for (let option in field.type){
                                let selected = '';
                                if(field.type[option] === data || field.type[option] === field.default){
                                    selected = ' selected="selected"';
                                }

                                options.push(`<option${selected}>${field.type[option]}</option>`);
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
                            if(field.type!=="date"){
                                input.attr['type'] = "datetime-local";
                                format = 'Y-M-DTh:m:s';
                            }
                            if(!data instanceof Date){
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