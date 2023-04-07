const Entity = require("../Entity");
class Payment extends Entity {
    _editable = {"contract_id":[1,"contract_id"],"amount":[2,"amount"],"period":[3,"period"],"status":[4,"status","{\"0\":\"pending\",\"1\":\"payed\",\"2\":\"withdrawn\"}"],"date":[5,"date"],"comment":[6,"comment"]};
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
  "amount": {
    "name": "amount",
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
  "status": {
    "name": "status",
    "type": {
      "0": "pending",
      "1": "payed",
      "2": "withdrawn"
    },
    "letNull": false,
    "default": "pending",
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
    id;contract_id;amount;period;status;date;comment;
    constructor () {
        super();
    }
}
module.exports = new Payment();