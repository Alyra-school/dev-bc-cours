const Web3 = require('web3')
const rpcURL = "https://ropsten.infura.io/v3/Your-Project-ID"
const web3 = new Web3(rpcURL)
 
web3.eth.getBalance("0xb8c74A1d2289ec8B13ae421a0660Fd96915022b1", (err, wei) => { 
   balance = web3.utils.fromWei(wei, 'ether'); // convertir la valeur en ether
   console.log(balance);
});
