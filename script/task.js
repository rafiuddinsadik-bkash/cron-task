const fs = require('fs');

const d  = new Date();

const year = d.getFullYear();
const month = d.getMonth()+1;
const day  = d.getDate();

const hour = d.getHours()+6;
const minutes = d.getMinutes();
const seconds = d.getSeconds();

const filename = 'output_'+year+month+day+'-'+hour+minutes+seconds;
const content = String(new Date());

if (!fs.existsSync('cronfiles')){
        fs.mkdirSync('cronfiles');
}

fs.writeFile(`cronfiles/${filename}.txt`, content,
        err => { if (err) { console.error(err)}
        // file written successfully
});