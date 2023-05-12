const Helper = require('./helper');
console.log(Helper.formatDate(Helper.getDate(),'M.Y'));


const { readdirSync, rename,renameSync } = require('fs');
const { resolve } = require('path');

// Get path to image directory
const imageDirPath = resolve(__dirname, '../models');

// Get an array of the files inside the folder
const files = readdirSync(imageDirPath);
console.log(files)
// Loop through each file that was retrieved
files.forEach(file => {
    const oldPath = imageDirPath + `/${file}`;

    // lowercasing the filename
    const newPath = imageDirPath + `/${file.toLowerCase()}`;
    console.log(newPath);
    // Rename file
    /*rename(
        oldPath,
        newPath,
        err => err?console.log(err):null
    );*/
    //renameSync(oldPath, newPath+'.bkp');
    //renameSync(newPath+'.bkp', newPath);
});
