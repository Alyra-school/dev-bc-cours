// ERC20Token.sol
// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;
 
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";
 
contract ERC20Token is ERC20 {   
   constructor() ERC20("NOM DE VOTRE TOKEN", "???") {
   }
}
