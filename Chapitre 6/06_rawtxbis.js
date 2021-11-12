var Tx     = require('ethereumjs-tx').Transaction
const Web3 = require('web3')
const web3 = new Web3('https://ropsten.infura.io/v3/Your-Project-ID')
const ABI = [
	{
		"inputs": [],
		"name": "get",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "x",
				"type": "uint256"
			}
		],
		"name": "set",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	}
]
const SSaddress = 'CONTRACT-ADDRESS'; //Addres of SimpleStorage contract
const account1 = 'PUBLIC-ADDRESS'; //Your account address 1
const privateKey1 = Buffer.from('PRIVATE-KEY', 'hex');
 
// Deploy the contract
web3.eth.getTransactionCount(account1, (err, txCount) => {
	const simpleStorage = new web3.eth.Contract(ABI, SSaddress);
	const data = simpleStorage.methods.set(3).encodeABI();
	const txObject = {
		nonce:    web3.utils.toHex(txCount),
		gasLimit: web3.utils.toHex(1000000), 
		gasPrice: web3.utils.toHex(web3.utils.toWei('10', 'gwei')),
		to: SSaddress,
		data: data
	}
 
	var tx = new Tx(txObject, {'chain':'ropsten'});
	tx.sign(privateKey1)

	const serializedTx = tx.serialize()
	const raw = '0x' + serializedTx.toString('hex')

	web3.eth.sendSignedTransaction(raw, (err, txHash) => {
		console.log('txHash:', txHash, 'err:', err)
		//Use this txHash to find the contract on Etherscan!
	})
})
