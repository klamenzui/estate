const Entity = require("../Entity");
class Capital extends Entity {
    _editable = {"sum":[1,"sum"],"date":[2,"date"],"currency":[3,"currency","{\"0\":\"EUR\",\"1\":\"HRN\",\"2\":\"USD\"}"],"exchange_rate":[4,"exchange_rate"],"comment":[5,"comment"]};
    _fields = {
  "id": {
    "name": "id",
    "type": [
      "int",
      11
    ],
    "letNull": false,
    "default": null,
    "key": "PRI",
    "extra": "auto_increment"
  },
  "sum": {
    "name": "sum",
    "type": "float",
    "letNull": false,
    "default": null,
    "key": "",
    "extra": ""
  },
  "date": {
    "name": "date",
    "type": "timestamp",
    "letNull": false,
    "default": "CURRENT_TIMESTAMP",
    "key": "",
    "extra": ""
  },
  "currency": {
    "name": "currency",
    "type": {
      "0": "EUR",
      "1": "HRN",
      "2": "USD"
    },
    "letNull": false,
    "default": "EUR",
    "key": "",
    "extra": ""
  },
  "exchange_rate": {
    "name": "exchange_rate",
    "type": "float",
    "letNull": false,
    "default": null,
    "key": "",
    "extra": ""
  },
  "comment": {
    "name": "comment",
    "type": [
      "varchar",
      255
    ],
    "letNull": false,
    "default": null,
    "key": "",
    "extra": ""
  }
};
    _primary_key = "id";_auto_increment = "id";
    id;sum;date;currency;exchange_rate;comment;
    constructor () {
        super();
    }
}
module.exports = new Capital();