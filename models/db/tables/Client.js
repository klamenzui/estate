const Entity = require("../Entity");
class Client extends Entity {
    _editable = {"first_name":[1,"first_name"],"last_name":[2,"last_name"]};
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
  "first_name": {
    "name": "first_name",
    "type": [
      "varchar",
      15
    ],
    "letNull": false,
    "default": null,
    "key": "",
    "extra": ""
  },
  "last_name": {
    "name": "last_name",
    "type": [
      "varchar",
      15
    ],
    "letNull": false,
    "default": null,
    "key": "",
    "extra": ""
  }
};
    _primary_key = "id";_auto_increment = "id";
    id;first_name;last_name;
    constructor () {
        super();
    }
}
module.exports = new Client();