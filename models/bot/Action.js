class Action {
    cmd = null;
    add() {
        //todo: new indent
        let res = 'Прости, но я еще это не умею';
        /*this.manager.addAnswer('ru', 'greetings.bye', 'Till next time');
        if(this.lastReq){
          this.addData( this.lastReq.utterance, 'user.'+data.action);
          res = 'Спасибо, исправился это '+(data.action?''+data.action:'');
        }*/
        return res;
    }

    correction() {
        let res = 'Прости, но я не понял';
        // All the required data to book is present => process the reservation
        if (this.cmd) {
            if(this.lastReq){
                this.addData( this.lastReq.utterance, 'action.'+this.cmd);
                res = 'Спасибо, исправился это '+(this.cmd?''+this.cmd:'');
                this.correction_step = 0;
            }

        } else if(this.lastReq){
            this.nextIntent = "action.correction";
            res =  "Прошу что это? укажи пожалуйста правильное действие";
            this.correction_step = 1;
        }
        console.log(res);
        return res;
    }
}
module.exports = Action;