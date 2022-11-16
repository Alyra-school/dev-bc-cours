async function main() {

    // npm install --prefix . @uniswap/sdk @truffle/hdwallet-provider web3 dotenv
    // https://github.com/Uniswap/v3-core/blob/main/contracts/UniswapV3Pool.sol
    // https://github.com/Uniswap/v3-periphery/blob/main/contracts/SwapRouter.sol
    // Pour l'instant erreur LOK du guard de reentrency : https://docs.uniswap.org/protocol/reference/error-codes

    var  Web3  =  require('web3');

    require('dotenv').config();
    const HDWalletProvider = require('@truffle/hdwallet-provider');
    const { ChainId, Fetcher, WETH, Route, Trade, TokenAmount, TradeType, Percent } = require('@uniswap/sdk');
    const { BN } = require ("web3-utils");


    provider = new HDWalletProvider(`${process.env.MNEMONIC}`, `https://goerli.infura.io/v3/${process.env.INFURA_ID}`)
    web3 = new Web3(provider);
    
    const chainId = ChainId.GOERLI;
    const tokenAddress = ''; // ADDRESS DU TOKEN SUR VOTRE TESTNET 
     
    const dai = await Fetcher.fetchTokenData(chainId, tokenAddress);
    const weth = WETH[chainId];
    const pair = await Fetcher.fetchPairData(dai, weth);
    const route = new Route([pair], weth);
    const trade = new Trade(route, new TokenAmount(weth, '10000000000000000'), TradeType.EXACT_INPUT);

    console.log("Les valeurs:");
    console.log("Combien de DAI pour 1 WETH: " + route.midPrice.toSignificant(6));
    console.log("Combien de Weth pour 1 Dai: " + route.midPrice.invert().toSignificant(6));
    console.log("Prix moyen du trade: " + trade.executionPrice.toSignificant(6));
    console.log("Vrai prix a l'instant T: " + trade.nextMidPrice.toSignificant(6));
    
    const slippageTolerance = new Percent('50', '10000'); // tolérance prix 50 bips = 0.050%
    
    // Les différents paramètres de exactInputSingle (venant de la struct ExactInputSingleParams )
    // voir https://github.com/Uniswap/v3-periphery/blob/main/contracts/interfaces/ISwapRouter.sol
    const _tokenIn = dai.address;
    const _tokenOut = weth.address;
    const _fee = 500; // 0.05%
    const _recipient = "";   // ADRESSE A CHANGER POUR LA VOTRE

    const _deadline = Math.floor(Date.now() / 1000) + 60 * 20; // le délai après lequel le trade n’est plus valable 
    const _amountIn = trade.minimumAmountOut(slippageTolerance).raw[0]; // minimum des tokens à récupérer avec une tolérance de 0.050%
    const _amountOutMinimum = 0; //Mettre à 0 de manière naive (ce sera forcément plus). En vrai, utiliser un oracle pour déterminer cette valeur précisément.
    const _sqrtPriceLimitX96 = 0; // Assurer le swap au montant exact
    
    const value = trade.inputAmount.raw; // la valeur des ethers à envoyer 
    
    const uniswapABI = [
        {
            "inputs": [
                {
                    "components": [
                        {
                            "internalType": "address",
                            "name": "tokenIn",
                            "type": "address"
                        },
                        {
                            "internalType": "address",
                            "name": "tokenOut",
                            "type": "address"
                        },
                        {
                            "internalType": "uint24",
                            "name": "fee",
                            "type": "uint24"
                        },
                        {
                            "internalType": "address",
                            "name": "recipient",
                            "type": "address"
                        },
                        {
                            "internalType": "uint256",
                            "name": "deadline",
                            "type": "uint256"
                        },
                        {
                            "internalType": "uint256",
                            "name": "amountIn",
                            "type": "uint256"
                        },
                        {
                            "internalType": "uint256",
                            "name": "amountOutMinimum",
                            "type": "uint256"
                        },
                        {
                            "internalType": "uint160",
                            "name": "sqrtPriceLimitX96",
                            "type": "uint160"
                        }
                    ],
                    "internalType": "struct ISwapRouter.ExactInputSingleParams",
                    "name": "params",
                    "type": "tuple"
                }
            ],
            "name": "exactInputSingle",
            "outputs": [
                {
                    "internalType": "uint256",
                    "name": "amountOut",
                    "type": "uint256"
                }
            ],
            "stateMutability": "payable",
            "type": "function"
        }
    ]
    
    var  uniswap  =  new  web3.eth.Contract(uniswapABI, '0xE592427A0AEce92De3Edee1F18E0157C05861564');

    console.log("---------------");
    console.log("---------------");

    const params = {
        tokenIn: _tokenIn,
        tokenOut: _tokenOut,
        fee: _fee,
        recipient: _recipient,
        deadline: _deadline,
        amountIn: _amountIn,
        amountOutMinimum: _amountOutMinimum,
        sqrtPriceLimitX96: _sqrtPriceLimitX96,
    }
    console.log("Lancement de la transaction avec les parametres suivant: ");
    console.log(params);

    console.log("---------------");
    console.log("---------------");

    try{
        const tx =  await uniswap.methods.exactInputSingle(params)
        .send({ value: new BN(value), gasPrice: 20e9, from: '' });
                   // ADRESSE A CHANGER POUR LA VOTRE


        
        console.log("ca maarche");
        console.log('Transaction hash: ');
        console.log(tx); // afficher le hash de la transaction 

    } catch(error) { 
        console.log("ok marche pas: " + error) 
    }

    process.exit(0);

}
     
    
main();
