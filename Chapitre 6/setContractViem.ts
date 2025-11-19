import { createPublicClient, http , getContract} from 'viem';
import { Address, mnemonicToAccount, privateKeyToAccount } from 'viem/accounts';
import { sepolia } from 'viem/chains';

const rpcURL = "YOUR RPC URL"

const client = createPublicClient({
  chain: sepolia,
  transport: http(),
});

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
		];
        
const SSaddress = "0x1100b96187FB08460F7f1010c38557C4e61Fc426";

const simpleStorage = getContract({
  address: SSaddress,
  abi: ABI,
  client: client,
});

// const account = privateKeyToAccount("YOUR PRIVATE KEY"); 

const account = mnemonicToAccount('YOUR MNEMONIC PHRASE'); 


const value = await simpleStorage.read.retrieve();
console.log(value);
const tx = await simpleStorage.write.store([42], { account });
console.log(tx);
const transaction = await client.waitForTransactionReceipt({ hash: tx });
console.log(tx);
console.log(transaction);
const value1 = await simpleStorage.read.retrieve();
console.log(value1);