const Entity = require("../Entity");
class Utilityservice extends Entity {
    _editable = {"name":[1,"name"],"unit":[2,"unit"],"description":[3,"description"],"date":[4,"date"],"tariff_url":[5,"tariff_url"],"tariff_selector":[6,"tariff_selector"]};
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
  "name": {
    "name": "name",
    "type": [
      "varchar",
      100
    ],
    "letNull": false,
    "default": null,
    "key": "",
    "extra": ""
  },
  "unit": {
    "name": "unit",
    "type": [
      "char",
      20
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
    "extra": ""
  },
  "tariff_url": {
    "name": "tariff_url",
    "type": "text",
    "letNull": false,
    "default": null,
    "key": "",
    "extra": ""
  },
  "tariff_selector": {
    "name": "tariff_selector",
    "type": "text",
    "letNull": false,
    "default": null,
    "key": "",
    "extra": ""
  }
};
    _primary_key = "id";_auto_increment = "id";
    id;name;unit;description;date;tariff_url;tariff_selector;
    constructor () {
        super();
    }
}
module.exports = new Utilityservice();