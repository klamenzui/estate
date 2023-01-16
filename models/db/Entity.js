//const Model = require("./Model");
//const table_scheme = require('../utils/table_scheme');
const Field = require("./Field");

class Entity {
    _editable = {};
    _fields = {};
    _shortName = null;
    _primary_key = null;
    _auto_increment = null;
    constructor() {
        return new Proxy(this, this);
    }

    get(target, prop) {
        //console.log(target,prop,this._fields[prop],typeof prop);
        if(typeof this[prop] != 'function' && typeof prop == 'string' && (''+prop)[0] !== '_'){
            this[prop] = new Field(this.getTableName(), this._fields[prop]);
        }
        return this[prop];
    }

    as(shortName) {
        this._shortName = shortName;
        return this;
    }

    getTableName(withAs) {
        let res = `${this.constructor.name}`.toLowerCase();
        if (this._shortName != null) {
            if (withAs) {
                res += ' as ' + this._shortName;
            } else {
                res = this._shortName;
            }
        }
        return res;
    }

    get primary_key(){
        return this._primary_key;
    }

    get auto_increment(){
        return this._auto_increment;
    }

    toString() {
        return this.getTableName(true);
    }

}

module.exports = Entity