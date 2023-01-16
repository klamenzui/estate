const Entity = require("../Entity");
class Contract extends Entity {
    _editable = {"client_id":[1,"client_id"],"estate_id":[2,"estate_id"],"status":[3,"status","{\"0\":\"active\",\"1\":\"closed\",\"2\":\"freezed\"}"],"period_type":[4,"period_type","{\"0\":\"daily\",\"1\":\"weekly\",\"2\":\"monthly\"}"],"price":[5,"price"],"date_start":[6,"date_start"],"date_end":[7,"date_end"]};
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
  "client_id": {
    "name": "client_id",
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
  "status": {
    "name": "status",
    "type": {
      "0": "active",
      "1": "closed",
      "2": "freezed"
    },
    "letNull": false,
    "default": null,
    "key": "",
    "extra": ""
  },
  "period_type": {
    "name": "period_type",
    "type": {
      "0": "daily",
      "1": "weekly",
      "2": "monthly"
    },
    "letNull": false,
    "default": "monthly",
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
  "date_start": {
    "name": "date_start",
    "type": "timestamp",
    "letNull": false,
    "default": "CURRENT_TIMESTAMP",
    "key": "",
    "extra": ""
  },
  "date_end": {
    "name": "date_end",
    "type": "datetime",
    "letNull": false,
    "default": null,
    "key": "",
    "extra": ""
  }
};
    _primary_key = "id";_auto_increment = "id";
    id;client_id;estate_id;status;period_type;price;date_start;date_end;
    constructor () {
        super();
    }
}
module.exports = new Contract();