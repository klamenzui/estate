const Entity = require("../Entity");
class Payment extends Entity {
    _editable = {"contract_id":[1,"contract_id"],"summe":[2,"summe"],"period":[3,"period"],"date":[4,"date"],"comment":[5,"comment"]};
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
  "contract_id": {
    "name": "contract_id",
    "type": [
      "int",
      11
    ],
    "letNull": false,
    "default": null,
    "key": "MUL",
    "extra": ""
  },
  "summe": {
    "name": "summe",
    "type": "float",
    "letNull": false,
    "default": null,
    "key": "",
    "extra": ""
  },
  "period": {
    "name": "period",
    "type": "timestamp",
    "letNull": false,
    "default": "CURRENT_TIMESTAMP",
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
  "comment": {
    "name": "comment",
    "type": "text",
    "letNull": false,
    "default": null,
    "key": "",
    "extra": ""
  }
};
    _primary_key = "id";_auto_increment = "id";
    id;contract_id;summe;period;date;comment;
    constructor () {
        super();
    }
}
module.exports = new Payment();