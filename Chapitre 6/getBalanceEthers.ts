import {ethers} from 'ethers';
const rpcURL = "YOUR RPC URL"

const client = new ethers.JsonRpcProvider(rpcURL);
  
const balance = await client.getBalance("0x13bc18faeC7f39Fb5eE428545dBba611267AEAa4");
console.log(ethers.formatEther(balance));

