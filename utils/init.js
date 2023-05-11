//const mysql = require('mysql');
//const util = require('util');
fs = require('fs');
const fsSyn = require("fs/promises");
const path = require("path");
const os = require('os');
const mysqldump = require('mysqldump');

// source: http://stackoverflow.com/questions/5645058/how-to-add-months-to-a-date-in-javascript

Date.isLeapYear = function (year) {
    return (((year % 4 === 0) && (year % 100 !== 0)) || (year % 400 === 0));
};

Date.getDaysInMonth = function (year, month) {
    return [31, (Date.isLeapYear(year) ? 29 : 28), 31, 30, 31, 30, 31, 31, 30, 31, 30, 31][month];
};

Date.prototype.isLeapYear = function () {
    return Date.isLeapYear(this.getFullYear());
};

Date.prototype.getDaysInMonth = function () {
    return Date.getDaysInMonth(this.getFullYear(), this.getMonth());
};

Date.prototype.addMonths = function (value) {
    var n = this.getDate();
    this.setDate(1);
    this.setMonth(this.getMonth() + value);
    this.setDate(Math.min(n, this.getDaysInMonth()));
    return this;
};

let netData = {};
const nets = os.networkInterfaces();
/* Iterating over the keys of the nets object. */
for (const name of Object.keys(nets)) {
    for (const net of nets[name]) {
        if (net.family === 'IPv4' && !net.internal) {
            if (!net[name]) {
                netData[name] = [];
            }
            netData[name].push(net.address);
        }
    }
}

let fileCrt = path.join(app.locals.base,'utils/ssl/my.key');
fs.accessSync(fileCrt, fs.constants.R_OK);
fileCrt = path.join(app.locals.base,'utils/ssl/my.pem');
fs.accessSync(fileCrt, fs.constants.R_OK);

// config/database.js
let init = {
    db: {
        'host': 'localhost',
        'port': 3306,
        'user': '0fe_20078041',
        'password': '310129',
        'database': 'estate',
        //timezone: 'gmt+6'  //<-here this line was missing 'utc'
        //paginate_page_size: 10
    },
    ip: (typeof netData["WLAN"] == 'undefined'? netData["eno1"][0]: netData["WLAN"][0]),
    certificate: fileCrt
};

app.locals.knex = require('knex')({
    client: 'mysql',
    connection: init.db
});

app.locals.knex.on('query', data => {
    //console.log('----------[query]-------------');
    //console.log(data);
    //console.log('-----------------------');
});

app.locals.knex.on('query-response', (data, obj, builder) => {
    //console.log('----------[query-response]-------------');
    //console.log(data, obj, builder);
    //console.log('-----------------------');
});

app.locals.knex.on('query-error', function (err, obj) {
    console.log('----------[query-error]-------------');
    console.log(err, obj);
    console.log('-----------------------');
});

//config.db['connection'] = mysql.createConnection(config.db);
//config.db.connection.connect();
/*config.db.connection.query('USE ' + config.db.name,[],(err, res) => {
    if(err) {
        console.log(err);
    }
});*/
//const query = util.promisify(config.db.connection.query).bind(config.db.connection);
/*
(async () => {
    try {
        await query('USE ' + config.db.name);

    } finally {
        //conn.end();
    }
})()*/

/*
    ALTER TABLE user ADD FOREIGN KEY (`role_id`) REFERENCES `role`(id);
 */
/* Creating a file for each table in the database. */
init['loadScheme'] = async () => {
    if (typeof init['table_scheme'] == 'undefined') {
        const directory = app.locals.base + 'models/db/tables/';
        // remove all files in folder tables
        for (const file of await fsSyn.readdir(directory)) {
            console.log(path.join(directory, file));
            await fsSyn.unlink(path.join(directory, file));
        }

        init['table_scheme'] = {};
        var tables = await app.locals.knex.raw(`SHOW TABLES`);
        console.log(tables);
        tables = tables[0];
        console.log(tables);
        for (let k in tables) {
            let table = tables[k]['Tables_in_' + init.db.database];
            try {
                var row = await app.locals.knex.raw(`DESCRIBE ${(table)}`);
                //var rows =  app.locals.knex.table(config.table[k]).columnInfo() ;
                row = row[0];
                let ts = {};
                let addFields = [];
                let editable = {};
                for (let i in row) {
                    let type = row[i].Type;
                    let field = row[i].Field;
                    if (type.startsWith('enum')) {
                        type = Object.assign({}, type.substring(6, type.length - 2).split("','"));
                    } else if (type.indexOf('(') > -1) {
                        type = type.substr(0, type.length - 1).split('(');
                        type[1] = parseInt(type[1]);
                    }
                    ts[field] = {
                        //full: config.table[k]+'.'+row[i].Field,
                        name: field,
                        type: type,
                        letNull: row[i].Null !== 'NO',
                        default: row[i].Default,
                        key: row[i].Key,
                        extra: row[i].Extra
                    };
                    if (row[i].Key === 'PRI') {
                        addFields.push('_primary_key = "' + field + '";');
                    } else {
                        editable[field] = [parseInt(i), field];
                        if(typeof type == 'object' && !Array.isArray(type)){
                            editable[field].push(JSON.stringify(type));
                        }
                    }
                    if (row[i].Extra === 'auto_increment') {
                        addFields.push('_auto_increment = "' + field + '";');
                    }
                }
                init['table_scheme'][table] = ts;
                console.log('describe: ', ts);
                let className = table;//[0].toUpperCase() + table.substring(1);
                let src_code = `const Entity = require("../Entity");
class ${className} extends Entity {
    _editable = ${JSON.stringify(editable)};
    _fields = ${JSON.stringify(ts, null, 2)};
    ${addFields.join('')}
    ${Object.keys(ts).join(";")};
    constructor () {
        super();
    }
}
module.exports = new ${className}();`;
                await fsSyn.writeFile(directory + className + '.js', src_code);
                console.log('table_scheme saved');
            } catch (e) {
                console.log(e);
            }
        }
    }

    /* Creating a backup of the database. */
    mysqldump({
        connection: init.db,
        dumpToFile: `${app.locals.base}models/db/estate.sql`,
    });
}

//const host = 'localhost:8080';//(`${process.env.NODE_ENV}` === "dev") ? `${process.env.HOST2}` : `${process.env.HOST}`;//private field
//const user = 'root';//(`${process.env.NODE_ENV}` === "dev") ? `${process.env.USER2}` : `${process.env.USER}`;//private field
//const pass = 'usbw';//(`${process.env.NODE_ENV}` === "dev") ? `${process.env.PASS2}` : `${process.env.PASS}`;//private field
//const database = 'mvc';//(`${process.env.NODE_ENV}` === "dev") ? `${process.env.DB2}` : `${process.env.DB}`;//private field
console.log(init);

/*
//database: database connection via pool
const pool = mysql.createPool({
    connectionLimit: 10,
    host: host,
    user: user,
    password: pass,
    database: database,
    timezone: 'gmt+6'  //<-here this line was missing 'utc'
});
*/

// pool.on('acquire', function (connection) {
//     console.log('Connection %d acquired', connection.threadId);
// });

// pool.on('release', function (connection) {
//     console.log('Connection %d released', connection.threadId);
// });


// pool.connect((e) => {
//     if (e) {
//         console.log("conection failed! error: " + e.message);
//         return;
//     }
//     console.log("conection success");
// });


module.exports = init