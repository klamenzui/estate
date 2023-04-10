const Entity = require("../Entity");
class Utilityservice_invoice extends Entity {
    _editable = {"utilityservice_id":[1,"utilityservice_id"],"meter_before":[2,"meter_before"],"meter_current":[3,"meter_current"],"amount":[4,"amount"],"price":[5,"price"],"status":[6,"status","{\"0\":\"pending\",\"1\":\"payed\"}"],"period":[7,"period"],"date":[8,"date"],"attachment_file":[9,"attachment_file"]};
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
  "utilityservice_id": {
    "name": "utilityservice_id",
    "type": [
      "int",
      11
    ],
    "letNull": false,
    "default": null,
    "key": "",
    "extra": ""
  },
  "meter_before": {
    "name": "meter_before",
    "type": [
      "int",
      11
    ],
    "letNull": false,
    "default": null,
    "key": "",
    "extra": ""
  },
  "meter_current": {
    "name": "meter_current",
    "type": [
      "int",
      11
    ],
    "letNull": false,
    "default": null,
    "key": "",
    "extra": ""
  },
  "amount": {
    "name": "amount",
    "type": "double",
    "letNull": false,
    "default": null,
    "key": "",
    "extra": ""
  },
  "price": {
    "name": "price",
    "type": "double",
    "letNull": false,
    "default": null,
    "key": "",
    "extra": ""
  },
  "status": {
    "name": "status",
    "type": {
      "0": "pending",
      "1": "payed"
    },
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
    "extra": "on update CURRENT_TIMESTAMP"
  },
  "attachment_file": {
    "name": "attachment_file",
    "type": [
      "varchar",
      100
    ],
    "letNull": false,
    "default": null,
    "key": "",
    "extra": ""
  }
};
    _primary_key = "id";_auto_increment = "id";
    id;utilityservice_id;meter_before;meter_current;amount;price;status;period;date;attachment_file;
    constructor () {
        super();
    }
}
module.exports = new Utilityservice_invoice();