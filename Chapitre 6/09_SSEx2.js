const Web3 = require('web3')
const rpcURL = "https://ropsten.infura.io/v3/Your-Project-ID"
const web3 = new Web3(rpcURL)
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
	}
];
const SSaddress = "0x9a5eA74972849E85e258A0B13f3ea22083B219ab ";
const simpleStorage = new web3.eth.Contract(ABI, SSaddress);
simpleStorage.methods.get().call((err, data) => {
 console.log(data);
});
