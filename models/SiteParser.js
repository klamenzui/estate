const Helper = require('../utils/helper');
const Page = require('../controllers/page');
const vm = require('vm');
const https = require('https');
const cheerio = require('cheerio');
class SiteParser {
    constructor() {
    }
    parse(url, selector, callback){
        https.get(url, (res) => {
            let html = '';
            res.on('data', (chunk) => {
                html += chunk;
            });
            res.on('end', () => {
                const $ = cheerio.load(html);
                let context = {
                    '$':$,
                    'res': {}
                };
                vm.createContext(context);
                for(let sel in selector){
                    sel = selector[sel].trim().replace(/%me%/g,'res');
                    const code = (sel.startsWith('.')?'res=res':'res=')+sel+';';
                    vm.runInContext(code, context);
                    console.log(context.res);
                }
                console.log('----');
                callback(context.res);
            });
        }).on('error', (err) => {
            console.error(`Error fetching ${url}: ${err.message}`);
        });
    }
}

module.exports = SiteParser