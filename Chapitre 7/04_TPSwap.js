const { ChainId, Fetcher, WETH, Route, Trade, TokenAmount, TradeType, Percent } = require('@uniswap/sdk');
const ethers = require('ethers');
 
const chainId = ChainId.MAINNET;
const tokenAddress = '0x6B175474E89094C44Da98b954EedeAC495271d0F'; // DAI address mainnet
 
const init = async () => {
 const dai = await Fetcher.fetchTokenData(chainId, tokenAddress);
 const weth = WETH[chainId];
 const pair = await Fetcher.fetchPairData(dai, weth);
 const route = new Route([pair], weth);
 const trade = new Trade(route, new TokenAmount(weth, '100000000000000000'), TradeType.EXACT_INPUT);
 console.log(route.midPrice.toSignificant(6));
 console.log(route.midPrice.invert().toSignificant(6));
 console.log(trade.executionPrice.toSignificant(6));
 console.log(trade.nextMidPrice.toSignificant(6));
 
 const slippageTolerance = new Percent('50', '10000'); // tolérance prix 50 bips = 0.050%
 
 const amountOutMin = trade.minimumAmountOut(slippageTolerance).raw; // minimum des tokens à récupérer avec une tolérance de 0.050%
 const path = [weth.address, dai.address]; // les tokens à échanger
 const to = '';
 const deadline = Math.floor(Date.now() / 1000) + 60 * 20; // le délai après lequel le trade n’est plus valable 
 const value = trade.inputAmount.raw; // la valeur des ethers à envoyer 
}
 
init();