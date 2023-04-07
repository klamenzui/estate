const Entity = require("../Entity");
class Expense extends Entity {
    _editable = {"estate_id":[1,"estate_id"],"ref_estate_accessory_id":[2,"ref_estate_accessory_id"],"type":[3,"type","{\"0\":\"accessory\",\"1\":\"accommodation\",\"2\":\"service\"}"],"amount":[4,"amount"],"description":[5,"description"],"date":[6,"date"]};
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
  "estate_id": {
    "name": "estate_id",
    "type": [
      "int",
      11
    ],
    "letNull": false,
    "default": null,
    "key": "MUL",
    "extra": ""
  },
  "ref_estate_accessory_id": {
    "name": "ref_estate_accessory_id",
    "type": [
      "int",
      11
    ],
    "letNull": false,
    "default": null,
    "key": "MUL",
    "extra": ""
  },
  "type": {
    "name": "type",
    "type": {
      "0": "accessory",
      "1": "accommodation",
      "2": "service"
    },
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
  "description": {
    "name": "description",
    "type": [
      "varchar",
      255
    ],
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
  }
};
    _primary_key = "id";_auto_increment = "id";
    id;estate_id;ref_estate_accessory_id;type;amount;description;date;
    constructor () {
        super();
    }
}
module.exports = new Expense();