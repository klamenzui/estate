const Helper = require('../../utils/Helper')

/**
 * @description base model for all model
 * @property {db} this can be used to access the database
 */
//let config = require('../utils/config');
//DESCRIBE `ref_accommodation_accessory`
/*
Field |	Type |	Null |	Key |	Default |	Extra
id  |	int(11) |	NO  |	PRI |	NULL	|   auto_increment
accommodation_id |	int(11)|	|NO |		NULL
accessory_id |	int(11)|	|NO 	|	NULL
status |	enum('new','almost_new','normal','old')| |	NO |		NULL
 */
class Model {
    //mysql config
    db = app.locals.knex;
    table_scheme;
    primary_key;
    _asTable = false;
    _table;
    _row;
    _where = [];
    _params = [];
    _order = [];
    _select = {};
    _join = {};
    _tables = {};
    constructor(_table) {
        if(!_table){
            _table = this.constructor.name;
        }
        this.table = _table.toLowerCase();
    }

    get table() {
        return this._table
    }

    set table(table) {
        this._table = table;
        this.table_scheme = require('./tables/' + table);
        //console.log('table_scheme:', this.table_scheme);
        /*
        RowDataPacket {
            Field: 'id',
            Type: 'int(11)',
            Null: 'NO',
            Key: 'PRI',
            Default: null,
            Extra: 'auto_increment'
          },
          RowDataPacket {
            Field: 'type',
            Type: "enum('accessory','accommodation','service')",
            Null: 'NO',
            Key: '',
            Default: null,
            Extra: ''
          },
         */
        this.primary_key = this.table_scheme._primary_key;
        return this;
    }

    get row() {
        return this._row;
    }

    set row(r) {
        this._row = {};
        let fields = this.table_scheme._fields;
        for(let field in fields){
            if(typeof r[field] != 'undefined'){
                this._row[field] = r[field];
            }
        }
    }

    getWhere() {
        let res = '';
        if (this._where.length > 0) {
            res = 'WHERE ' + this._where.join(' ');
        }
        return res;
    }
/*
    set where(str) {
        this._where.push(str);
    }*/

    where(field, operator, val, logOperator) {
        if(typeof field == 'undefined'){
            return this.getWhere();
        }
        operator = operator? operator: '=';
        logOperator = logOperator? logOperator: 'AND';
        if (this._where.length === 0) {
            logOperator = '';
        }
        this._where.push(`${logOperator} ?? ${operator} ?`);
        this._params.push(''+field);
        this._params.push(val);
        return this;
    }

    orWhere(field, operator, val) {
        return this.where(field, operator, val, 'OR');
    }

    andWhere(field, operator, val) {
        return this.where(field, operator, val, 'AND');
    }


    get params() {
        return this._params;
    }

    set params(val) {
        this._params.push(val);
    }

    isAsTable() {
        return this._asTable;
    }

    setAsTable(value) {
        this._asTable = value;
        return this;
    }

    clearFilter() {
        this._where = [];
        this._params = [];
        return this;
    }

    setFilter(filter, operator, logOperator) {
        this.clearFilter();
        return this.addFilter(filter, operator, logOperator);
    }

    addFilter(filter, operator, logOperator) {
        if (!Helper.isEmpty(filter) && filter !== -1) {
            if (typeof filter != 'object') {
                filter = {[this.primary_key]: filter};
            }
            operator = operator ? operator: '=';
            logOperator = logOperator ? logOperator: 'AND';
            for (let key in filter) {
                let tableField = key;
                // if table name not set
                if (tableField.indexOf('.') === -1) {
                    tableField = `${this.table}.${tableField}`;
                }
                this.where(tableField, operator, filter[key], logOperator);
            }
        }
        return this;
    }

    async exec() {
        let sql = 'SELECT ' + Object.values(this._select).join(', ') +
            ` FROM ${this.table} \n` + Object.values(this._join).join('') + ` ${this.getWhere()}`;
        console.log(sql);
        return this.query(sql);
    }

    _addSelect(field) {
        if(field.table !== this.table){
            if(typeof this._join[field.table] == 'undefined'){
                let f_table_field = '';
                let m_table_field = ''
                let join_table = this._tables[field.table];
                for(let t in this._tables){
                    if('' + this._tables[t][join_table+'_'+join_table._primary_key] !== 'undefined'){
                        m_table_field = join_table[join_table._primary_key];
                        f_table_field = ''+this._tables[t][join_table+'_'+join_table._primary_key];
                        break;
                    } else if('' + join_table[this._tables[t]+'_'+this._tables[t]._primary_key] !== 'undefined'){
                        m_table_field = join_table[this._tables[t]+'_'+this._tables[t]._primary_key];
                        f_table_field = ''+this._tables[t][this._tables[t]._primary_key];
                        break;
                    }
                }
                this._join[field.table] = `LEFT JOIN ${join_table} ON( ${m_table_field} = ${f_table_field})\n`;
            }
        }
        if(typeof this._select[field.name] == 'undefined') {
            this._select[field.name] = field.full_name;
        } else {
            this._select[field.as()] = field.as();
        }
    }

    _addTable(table) {
        if(typeof this._tables[table] == 'undefined'){
            this._tables[table] = require('./tables/' + table);
        }
    }

    order(field, direction){
        if(typeof field == "undefined"){
            return (this._order.length === 0)? '': 'ORDER BY ' + this._order.join(',');
        }
        direction = direction? direction: 'ASC';
        if(this._order.length === 0){
            direction = '';
        }
        if(this._select[field.name] !== field.full_name) {
            this._order.push(field.as() + ' ' + direction);
        } else {
            this._order.push(field.full_name + ' ' + direction);
        }
        return this;
    }

    orderASC(field){
        return this.order(field, 'ASC');
    }

    orderDESC(field){
        return this.order(field, 'DESC');
    }

    select() {
        console.log(arguments);
        this._select = {};
        this._join = {};
        this._order = [];
        this._params = [];
        this._where = [];
        let from;
        for (let i = 0; i < arguments.length; i++){
            let field = arguments[i];
            let fields = [];
            if(field.constructor.name === 'Field'){
                fields = [field];
                this._addTable(field.table);
            } else {
                this._addTable(field.toString());
                for(let j in field._fields){
                    fields.push(field[j]);
                }
            }
            for(let j in fields){
                field = fields[j];
                if(typeof from == 'undefined') {
                    from = field.table;
                    this.table = from;
                }
                this._addSelect(field);
            }
        }
        return this;
    }
    /**
     * It takes a SQL query, executes it, and returns the results in a format that is suitable for the front-end
     * @param sql - The SQL query to be executed.
     * @returns The query is being returned.
     */
    async query(sql) {
        let fun = (results) => {
            let res = {};
            res['rows'] = (results && results[0] && results[0][0] ? results[0] : []);
            /* Checking if the data for a table. */
            if (this.isAsTable()) {
                /* Creating a variable called table_scheme and assigning it the value of the table_scheme property of the
                object that is calling the function. */
                let table_scheme = this.table_scheme;
                res['columns'] = {
                    //identifier: [0, table_scheme._primary_key],
                    primary_key: table_scheme._primary_key,
                    editable: [],
                    all: []
                }
                /* Parsing the results of the query and building a list of columns that are editable. */
                for (let i in results[1]) {
                    let table = results[1][i].orgTable;
                    let field = results[1][i].orgName && table === this.table ? results[1][i].orgName : results[1][i].name;
                    if (!Helper.isEmpty(table)) {
                        table_scheme = require('./tables/' + table);
                    } else {
                        table_scheme = this.table_scheme;
                        table = this.table;
                    }
                    res.columns.all.push(field);
                    if (results[1][i].orgName === table_scheme._primary_key /*|| this.table !== table*/) {
                        continue;
                    }
                    let col = table_scheme._editable[field];
                    if (!Helper.isEmpty(col)) {
                        col[0] = i;
                        col[1] = field;//table + '.' + field;
                        res.columns.editable.push(col);
                    }
                }
            }
            return res;
        }
        return this.db.raw(sql, this.params).then((res)=>{
            return fun(res);
        });
    }

    //common operation
    set = async (obj) => {
        let isNew = Helper.isEmpty(obj[this.primary_key]);
        if (isNew) {
            return this.add(obj);//.catch(callback);
        } else {
            return this.update(obj);
        }
    }

    get = async (filter) => {
        if(typeof filter !== 'undefined'){
            this.setFilter(filter);
        }
        return this.query(`SELECT * FROM ${(this.table)} ${(this.getWhere())}`);
    }
    //get a data
    /*getOne = async (field, value, callback) => {
        let sql = `SELECT * FROM ${(this.table)} WHERE ??=?`;
        this.db.raw(sql, [field, value]).then(callback).catch(callback);
    }*/

    //insert into a specific table
    /**
     * @param {what you want to insert} obj
     * @param {err,results()=>{}} callback
     */
    add = (obj) => {
        this.row = Helper.delKey(obj, this.primary_key);
        return this.db(this.table).insert(this.row);
    }
    //update a specific row on a table
    /**
     * @param {what you want to insert} obj
     * @param {err,results()=>{}} callback
     */
    update = (obj) => {
        this.row = Helper.delKey(obj, this.primary_key);
        let sql = `UPDATE ${(this.table)} SET ? WHERE ${this.primary_key} = ?`;
        return this.db.raw(sql, [this.row, obj[this.primary_key]]);
    }
    //delete a specific row on a table
    /**
     * @param {id} id
     * @param {err,results()=>{}} callback
     */
    del = (obj) => {
        return this.delete(obj);
    }

    delete = (obj) => {
        let id = (typeof obj == 'object'? obj[this.primary_key]: obj);
        let sql = `DELETE FROM ${(this.table)} WHERE ${this.primary_key} = ?`;
        return this.db.raw(sql, id);
    }
    //get all data from a table in decending order by a field
    /*getAll = async (field, callback) => {
        let params = [];
        let order = '';
        if (typeof field != 'undefined' && field != null) {
            order = `ORDER BY ?? DESC`;
            params.push(field);
        }
        let sql = `SELECT * from ${(this.table)} ${order}`;
        this.db.raw(sql, params).then(res => {
            callback(res);
        }).catch(err => {
            callback(err);
        });
    }*/

    //get all data from a table in filter by a field and order by field
    getAllByField = async (field, value, order_field, callback) => {
        let sql = `SELECT * from ${(this.table)} WHERE ?? =?  ORDER BY ?? DESC`;
        this.db.raw(sql, [field, value, order_field]).then(res => {
            callback(res);
        }).catch(err => {
            callback(err);
        });
    }

    //get all data from a table in decending order by a field with pagination
    /**
     * @param {page} page number (1,2,3,4..)
     * @param {field} where filter apply on which field
     * @param {value} where filter value
     * @param {order_field} order by field
     * @param {callback} (error,results)=>{}
     */
    getPaginateList = (page, field, value, field2 = "", value2 = -1, order_field, callback) => {

        //implement pagination here later
        const page_size = 50;
        let skip = (page - 1) * page_size;

        let sql = "";
        if (value2 === -1 && field2 === "") {
            sql = `SELECT * from ${(this.table)} WHERE ?? =? ORDER BY ?? DESC LIMIT ? OFFSET ? `;
            this.db.raw(sql, [field, value, order_field, page_size, skip]).then(res => {
                callback(res);
            }).catch(err => {
                callback(err);
            });
        } else {
            sql = `SELECT * from ${this.table} WHERE ?? =? AND ??=? ORDER BY ?? DESC LIMIT ? OFFSET ? `;
            this.db.raw(sql, [field, value, field2, value2, order_field, page_size, skip]).then(res => {
                callback(res);
            }).catch(err => {
                callback(err);
            });
        }

    }
}

module.exports = Model