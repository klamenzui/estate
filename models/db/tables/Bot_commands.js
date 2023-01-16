const Entity = require("../Entity");
class Bot_commands extends Entity {
    _editable = {"command":[1,"command"],"action_id":[2,"action_id"]};
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
  "command": {
    "name": "command",
    "type": "text",
    "letNull": false,
    "default": null,
    "key": "",
    "extra": ""
  },
  "action_id": {
    "name": "action_id",
    "type": [
      "int",
      11
    ],
    "letNull": false,
    "default": null,
    "key": "",
    "extra": ""
  }
};
    _primary_key = "id";_auto_increment = "id";
    id;command;action_id;
    constructor () {
        super();
    }
}
module.exports = new Bot_commands();