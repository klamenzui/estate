const Entity = require("../Entity");
class User extends Entity {
    _editable = {"username":[1,"username"],"email":[2,"email"],"password":[3,"password"],"role_id":[4,"role_id"]};
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
  "username": {
    "name": "username",
    "type": [
      "varchar",
      50
    ],
    "letNull": false,
    "default": null,
    "key": "",
    "extra": ""
  },
  "email": {
    "name": "email",
    "type": [
      "varchar",
      100
    ],
    "letNull": false,
    "default": null,
    "key": "",
    "extra": ""
  },
  "password": {
    "name": "password",
    "type": [
      "varchar",
      255
    ],
    "letNull": false,
    "default": null,
    "key": "",
    "extra": ""
  },
  "role_id": {
    "name": "role_id",
    "type": [
      "varchar",
      20
    ],
    "letNull": false,
    "default": null,
    "key": "MUL",
    "extra": ""
  }
};
    _primary_key = "id";_auto_increment = "id";
    id;username;email;password;role_id;
    constructor () {
        super();
    }
}
module.exports = new User();