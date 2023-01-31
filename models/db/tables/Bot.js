const Entity = require("../Entity");
class Bot extends Entity {
    _editable = {"name":[1,"name"],"token":[2,"token"],"pattern":[3,"pattern"],"options":[4,"options"],"nlp":[5,"nlp"],"useraccess":[6,"useraccess"]};
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
  "token": {
    "name": "token",
    "type": [
      "varchar",
      200
    ],
    "letNull": false,
    "default": null,
    "key": "",
    "extra": ""
  },
  "pattern": {
    "name": "pattern",
    "type": [
      "varchar",
      50
    ],
    "letNull": false,
    "default": null,
    "key": "",
    "extra": ""
  },
  "options": {
    "name": "options",
    "type": "text",
    "letNull": false,
    "default": null,
    "key": "",
    "extra": ""
  },
  "nlp": {
    "name": "nlp",
    "type": "text",
    "letNull": false,
    "default": null,
    "key": "",
    "extra": ""
  },
  "useraccess": {
    "name": "useraccess",
    "type": [
      "varchar",
      200
    ],
    "letNull": false,
    "default": null,
    "key": "",
    "extra": ""
  }
};
    _primary_key = "id";_auto_increment = "id";
    id;name;token;pattern;options;nlp;useraccess;
    constructor () {
        super();
    }
}
module.exports = new Bot();