
import { createPublicClient, http , formatEther} from 'viem';
import { sepolia } from 'viem/chains';

const rpcURL = "YOUR RPC URL"

const client = createPublicClient({
  chain: sepolia,
  transport: http(rpcURL),
});

const balance = await client.getBalance({ address: "0x13bc18faeC7f39Fb5eE428545dBba611267AEAa4" });
console.log(formatEther(balance));