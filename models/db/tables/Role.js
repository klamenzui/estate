const Entity = require("../Entity");
class Role extends Entity {
    _editable = {"name":[1,"name"],"description":[2,"description"]};
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
      15
    ],
    "letNull": false,
    "default": null,
    "key": "",
    "extra": ""
  },
  "description": {
    "name": "description",
    "type": [
      "varchar",
      100
    ],
    "letNull": true,
    "default": null,
    "key": "",
    "extra": ""
  }
};
    _primary_key = "id";_auto_increment = "id";
    id;name;description;
    constructor () {
        super();
    }
}
module.exports = new Role();