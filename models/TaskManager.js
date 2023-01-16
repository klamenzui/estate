const Model = require("./Task");
const cron = require('node-cron');

class TaskManager {
    model;
    mainTask;
    taskPool = {};

    constructor() {
        this.model = new Model();
        this.mainTask = cron.schedule('5 * * * * *', this.scan, {
            scheduled: false
        });
        this.mainTask.start();
    }

    scan = async () => {
        console.log('----[scan new tasks]----');
        await this.model.get().then((res) => {
            try {
                if(res && res.rows){
                    for(let i in res.rows){
                        let task = res.rows[i];
                        console.log('typeof task:', typeof this.taskPool[task.name]);
                        if(typeof this.taskPool[task.name] == "undefined"){
                            if(cron.validate(task.interval)){
                                this.taskPool[task.name] = cron.schedule(task.interval, this.getTaskFunction(task.name), {
                                    scheduled: false
                                });
                                this.taskPool[task.name].row = task;
                                this.taskPool[task.name].start();
                            } else {
                                console.log('task interval is incorrect:', task.interval);
                            }
                        }
                    }
                }
            }catch (e) {
                console.log(e)
            }
        });
    }

    getTaskFunction(name){
        let task = require('../tasks/'+name);
        return function(){
            try {
                task.exec();
            }catch (e) {
                console.log(`Task '${name}' error:`,e)
            }
        }

    }
}

module.exports = TaskManager