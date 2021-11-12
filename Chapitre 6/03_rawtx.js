var Tx     = require('ethereumjs-tx').Transaction
const Web3 = require('web3')
const web3 = new Web3('https://ropsten.infura.io/v3/Your-Project-ID')
 
const account1 = 'PUBLIC-ADDRESS'; // Your account address 1
const privateKey1 = Buffer.from('PRIVATE-KEY', 'hex');
 
// Deploy the contract
web3.eth.getTransactionCount(account1, (err, txCount) => {
   const data = '0x608060405234801561001057600080fd5b5060c78061001f6000396000f3fe6080604052348015600f57600080fd5b506004361060325760003560e01c806360fe47b11460375780636d4ce63c146062575b600080fd5b606060048036036020811015604b57600080fd5b8101908080359060200190929190505050607e565b005b60686088565b6040518082815260200191505060405180910390f35b8060008190555050565b6000805490509056fea2646970667358221220621b004348182090993209e1ac240f4afda9ce0872d638761289ca63d69be72264736f6c634300060b0033';
 
 const txObject = {
   nonce:    web3.utils.toHex(txCount),
   gasLimit: web3.utils.toHex(1000000), // Raise the gas limit to a much higher amount
   gasPrice: web3.utils.toHex(web3.utils.toWei('10', 'gwei')),
   data: data
 }
 
 var tx = new Tx(txObject, {'chain':'ropsten'});
 tx.sign(privateKey1)
 
 const serializedTx = tx.serialize()
 const raw = '0x' + serializedTx.toString('hex')
 
 web3.eth.sendSignedTransaction(raw, (err, txHash) => {
   console.log('txHash:', txHash, 'err:', err)
   // Use this txHash to find the contract on Etherscan!
 })
})
