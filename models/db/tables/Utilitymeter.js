const Entity = require("../Entity");
class Utilitymeter extends Entity {
    _editable = {"code":[1,"code"],"utilityservice_id":[2,"utilityservice_id"],"estate_id":[3,"estate_id"],"price":[4,"price"],"meter_before":[5,"meter_before"],"meter_current":[6,"meter_current"],"description":[7,"description"],"date":[8,"date"]};
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
  "code": {
    "name": "code",
    "type": [
      "varchar",
      100
    ],
    "letNull": false,
    "default": null,
    "key": "UNI",
    "extra": ""
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
  "estate_id": {
    "name": "estate_id",
    "type": [
      "int",
      11
    ],
    "letNull": false,
    "default": null,
    "key": "",
    "extra": ""
  },
  "price": {
    "name": "price",
    "type": "float",
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
  "description": {
    "name": "description",
    "type": "text",
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
    "extra": "on update CURRENT_TIMESTAMP"
  }
};
    _primary_key = "id";_auto_increment = "id";
    id;code;utilityservice_id;estate_id;price;meter_before;meter_current;description;date;
    constructor () {
        super();
    }
}
module.exports = new Utilitymeter();