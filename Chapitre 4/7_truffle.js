const HDWalletProvider = require('@truffle/hdwallet-provider');
require('dotenv').config();
 
module.exports = {
 networks: {
   develop: {
     host: "127.0.0.1",
     port: 8545,
     network_id: "*", 
   },
    Mumbai: {
     provider: function() {
       return new HDWalletProvider(`${process.env.MNEMONIC}`, `https://polygon-mumbai.g.alchemy.com/v2/${process.env.ALCHEMY_ID}`)
     },
     network_id: 80001
   },
    Sepolia: {
     provider: function() {
       return new HDWalletProvider(`${process.env.MNEMONIC}`, `https://sepolia.infura.io/v3/${process.env.INFURA_ID}`)
     },
     network_id: 11155111
   },
 },
 
 mocha: {
 },
 compilers: {
   solc: {
     version: "0.8.19",  
     settings: {  
       optimizer: {
       enabled: false,
       runs: 200
       },
     }
   },
 }
};
