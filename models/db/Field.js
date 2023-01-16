class Field {
    table;
    full_name;
    type;
    typeLen = -1;
    letNull = false;
    default = null;
    key = "";
    extra = ""
    constructor(table, field) {
        this.table = table;
        if(typeof field != 'undefined'){
            this.name = field.name;
            this.full_name = table + '.' + field.name;
            if(Array.isArray(field.type)){
                this.type = field.type[0];
                this.typeLen = field.type[1];
            }else{
                this.type = field.type;
                this.typeLen = -1;
            }
            this.letNull = field.letNull;
            this.default = field.default === 'CURRENT_TIMESTAMP'? new Date().toISOString().
            replace(/T/, ' ').
            replace(/\..+/, ''):field.default;
            this.key = field.key;
            this.extra = field.extra;

        }
    }

    as(shortName){
        if(typeof shortName == 'undefined'){
            shortName = `${this.table}_${this.name}`;
        }
        return `${this.full_name} as ${shortName}`;
    }

    format(format){
        let res = `DATE_FORMAT(${this.full_name}, "${format}") as ${this.name}`;
        return res;
    }

    toString() {
        return `${this.full_name}`;
    }

}

module.exports = Field;