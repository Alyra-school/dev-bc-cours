require('dotenv').config();
const key = process.env.PINATA_KEY;
const secret = process.env.PINATA_SECRET;
const pinataSDK = require('@pinata/sdk');
const pinata = pinataSDK(key, secret);
const fs = require('fs');
const path = require("path");
const dataJson = path.join(__dirname, 'data.json');
const sourceFolder = path.join(__dirname, 'img');
const options = {
    pinataMetadata: {
        name: "AlyraNFT",
        keyvalues: {
            img1: 'value1',
            img2: 'value2'
        }
    },
    pinataOptions: {
        cidVersion: 0
    }
};
pinata.pinFromFS(sourceFolder, options).then((result) => {
    fs.writeFileSync(dataJson,JSON.stringify(result));
    //handle results here
    console.log(result);
}).catch((err) => {
    //handle error here
    console.error(err);
});
