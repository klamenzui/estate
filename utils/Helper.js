const Helper = {
    /*
    //@get a date after 1 day @return miliseconds
    getExpireDay: (day = 1) => {
        return moment().add(day, Define.DAYS).valueOf();
    },
    //@return token:String
    getJWTtoken: (email, expires) => {
        if (expires) {
            return jwt.sign({ email: email }, process.env.ACCESS_SECRET, { expiresIn: expires });
        } else {
            return jwt.sign({ email: email }, process.env.ACCESS_SECRET);
        }
    },
    //@return email:String || throw Error
    verifyJWTtoken: (token) => {
        try {
            if (!token) {
                throw new Error("Unauthorized Access")
            }
            const email = jwt.verify(token, process.env.ACCESS_SECRET)
            return email
        } catch (e) {
            throw new Error("Unauthorized Access")
        }
    },
    */
    getMethod: (obj, mname) => {
        let currentObj = obj;
        mname = mname.toLowerCase();
        //let maxDeep = 3;
        do {
            let ownPropertyNames = Object.getOwnPropertyNames(currentObj);
            for (let k in ownPropertyNames) {
                let item = ownPropertyNames[k];
                console.log(item, mname);
                if (typeof obj[item] === 'function' && item.toLowerCase() === mname) {
                    return item;
                }
            }
            //maxDeep++;
        } while ((currentObj = Object.getPrototypeOf(currentObj)))
        return '';
    },
    isEmpty: (object) => {
        let res = false;
        if (object == null || object === 0 || object === '' || object === undefined ||
            object === [] || Object.keys(object).length === 0) {
            res = true;
        }
        return res;
    },
    delKey: (obj, key) => {
        const {[key]: unused, ...rest} = obj
        return rest
    },
    isError: (e) => {
        return e && e.stack && e.message && typeof e.stack === 'string'
            && typeof e.message === 'string';
    },
    getMonthDifference: (startDate, endDate) => {
        //console.log(getMonthDifference(new Date('2022-01-15'), new Date('2022-03-16')));
        return (
            endDate.getMonth() -
            startDate.getMonth() +
            12 * (endDate.getFullYear() - startDate.getFullYear())
        );
    },

    getTag: (obj) => {
        let tag_start = '';
        let tag_end = '';
        if (obj.tag) {
            tag_start = '<' + obj.tag;
            tag_end = '>' + (obj.html ? obj.html : '') + '</' + obj.tag + '>';
        }
        if (obj.attr) {
            for (let a in obj.attr) {
                tag_start += ` ${a} = "${obj.attr[a]}"`;
            }
        }
        return tag_start + tag_end;
    },

    getHtml: (obj) => {
        let res = '';
        if (obj) {
            for (let i in obj) {
                res += Helper.getTag(obj[i]);
            }
        }
        return res;
    },
    month_arr: [
        'январь',
        'февраль',
        'март',
        'апрель',
        'май',
        'июнь',
        'июль',
        'август',
        'сентябрь',
        'октябрь',
        'ноябрь',
        'декабрь',
    ],
    getDate: (str, monthPart) => {
        var now = new Date();
        var year = now.getFullYear();
        var month = now.getMonth() + 1;
        var date = now.getDate();
        if(typeof str.getDate == "function"){
            str = Helper.formatDate(str, 'Y-M-D h:m:s');
        }
        if (monthPart) {
            date = '01';
            month = Helper.month_arr.indexOf(str) + 1;
            if (now.getMonth() + 1 < month) {
                year = year - 1;
            }
        } else if (typeof str == 'string') {
            var pattern = /^([0-9]{2,4})[\.-]([0-9]{2})[\.-]([0-9]{2,4})$|^([0-9]{2,4})[\.-]([0-9]{2,4})$/;
            var m = str.match(pattern);
            if (m != null) {
                if (typeof m[4] == 'undefined') {
                    if (m[1].length == 4) {
                        year = m[1];
                        date = m[3];
                    } else {
                        year = m[3];
                        date = m[1];
                    }
                    month = m[2];
                } else {
                    date = '01';
                    if (m[4].length == 4) {
                        year = m[4];
                        month = m[5];
                    } else {
                        year = m[5];
                        month = m[4];
                    }
                }
            } else {
                console.log('Date format should be like: 01.01.2022 or 01.2022');
                return null;
            }
            date = parseInt(date);
            month = parseInt(month);
            if (month < 0 || month > 12) {
                console.log('Month limits: 01 - 12');
                return null;
            }
            if (date < 0 || date > 31) {
                console.log('Date limits: 01 - 31');
                return null;
            }
        }
        month = (month > 9 ? month : '0' + month);
        return year + '-' + month + '-' + date;
    },
    toNum: (str) =>{
        var res = str.match(/[0-9\\.,-\\+]+/);
        return res == null ? null: res[0];
    },
    formatDate: (dateSrc, format) => {
        var now = dateSrc? dateSrc: new Date();
        format = format? format: 'Y-M-D h:m:s';
        var year = now.getFullYear();
        var month = ("0"+(now.getMonth()+1)).slice(-2);
        var date = ("0" + now.getDate()).slice(-2);
        return format.replace('Y', year)
            .replace('M', month)
            .replace('D', date)
            .replace('h', ("0" + now.getHours()).slice(-2))
            .replace('m', ("0" + now.getMinutes()).slice(-2))
            .replace('s', ("0" + now.getSeconds()).slice(-2));
    }
}
module.exports = Helper