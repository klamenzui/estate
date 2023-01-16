const Entity = require("../Entity");
class Accessory extends Entity {
    _editable = {"name":[1,"name"]};
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
      255
    ],
    "letNull": false,
    "default": null,
    "key": "",
    "extra": ""
  }
};
    _primary_key = "id";_auto_increment = "id";
    id;name;
    constructor () {
        super();
    }
}
module.exports = new Accessory();