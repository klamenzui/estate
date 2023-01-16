const Entity = require("../Entity");
class Bot_chat extends Entity {
    _editable = {"code":[1,"code"],"title":[2,"title"],"type":[3,"type"],"all_members_are_administrators":[4,"all_members_are_administrators"],"status":[5,"status"]};
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
      50
    ],
    "letNull": false,
    "default": null,
    "key": "UNI",
    "extra": ""
  },
  "title": {
    "name": "title",
    "type": [
      "varchar",
      100
    ],
    "letNull": false,
    "default": null,
    "key": "",
    "extra": ""
  },
  "type": {
    "name": "type",
    "type": [
      "varchar",
      50
    ],
    "letNull": false,
    "default": null,
    "key": "",
    "extra": ""
  },
  "all_members_are_administrators": {
    "name": "all_members_are_administrators",
    "type": [
      "tinyint",
      1
    ],
    "letNull": false,
    "default": null,
    "key": "",
    "extra": ""
  },
  "status": {
    "name": "status",
    "type": [
      "tinyint",
      1
    ],
    "letNull": false,
    "default": null,
    "key": "",
    "extra": ""
  }
};
    _primary_key = "id";_auto_increment = "id";
    id;code;title;type;all_members_are_administrators;status;
    constructor () {
        super();
    }
}
module.exports = new Bot_chat();