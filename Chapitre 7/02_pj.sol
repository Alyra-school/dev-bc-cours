// MyDeFiProject.sol
pragma solidity 0.8.9;
import '@openzeppelin/contracts/token/ERC20/IERC20.sol';
 
contract MyDeFiProject {
	IERC20 dai;

	constructor(address daiAddress) {
		// injecter l'address du token Dai à utiliser
		dai = IERC20(daiAddress);
	}

	// fonction qui permet d'effectuer un transfer de dai vers le recipient
	function foo(address recipient, uint amount) external {
		// quelques instructions
		dai.transfer(recipient, amount);
	}
}
