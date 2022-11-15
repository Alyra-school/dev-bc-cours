require('dotenv').config();
const key = process.env.PINATA_KEY;
const secret = process.env.PINATA_SECRET;
const pinataSDK = require('@pinata/sdk');
const pinata = new pinataSDK(key, secret);
const fs = require('fs');
const readableStreamForFile = fs.createReadStream('image.png');

const options = {
    pinataMetadata: {
        name: "AlyraNFT",
    },
    pinataOptions: {
        cidVersion: 0
    }
};


pinata.pinFileToIPFS(readableStreamForFile, options).then((result) => {
    const body = {
        description: "Un NFT tres beau pour alyra.",
        image: result.IpfsHash,
        name: "BestNFT",
    };

    pinata.pinJSONToIPFS(body, options).then((json) => {
        console.log(json);
    }).catch((err) => {
        console.log(err);
    });

}).catch((err) => {
    console.log(err);
});
