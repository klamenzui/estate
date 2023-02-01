class Conversation {
    object;
    correction(){
        this.correction_step = 1;
        return  "Прошу прощения, а как правильно?";
    }

    filling(){
        return  "";
    }

    how() {
        let res = 'что как';
        if(this.object) {
            switch(this.object){
                case 'name':
                    res = this.constructor.bot.name;
                    break;
                case 'doing':
                    res = 'Хорошо, а ты?';
                    break;
            }
        }
        console.log(res);
        return res;
    }
}
module.exports = Conversation;