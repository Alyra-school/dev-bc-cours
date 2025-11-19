import {ethers, HDNodeWallet, Wallet} from 'ethers';
const rpcURL = "YOUR RPC URL"

const client = new ethers.JsonRpcProvider(rpcURL);

const ABI = [{
				"inputs": [],
				"name": "retrieve",
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
						"name": "num",
						"type": "uint256"
					}
				],
				"name": "store",
				"outputs": [],
				"stateMutability": "nonpayable",
				"type": "function"
			}
		] as const;
        
const SSaddress = "0x1100b96187FB08460F7f1010c38557C4e61Fc426";
const simpleStorage = new ethers.Contract(SSaddress, ABI, client);

const signer = new ethers.Wallet("YOUR PRIVATE KEY", client);

// const wallet = ethers.Mnemonic.fromPhrase("YOUR MNEMONIC PHRASE")
// const signer = HDNodeWallet.fromMnemonic(wallet, `m/44'/60'/0'/0/${0}`).connect(client);

const value1 = await simpleStorage.retrieve()
console.log(value1);
const tx = await simpleStorage.connect(signer).store(56);
await tx.wait();
const value = await simpleStorage.retrieve()
console.log(value);