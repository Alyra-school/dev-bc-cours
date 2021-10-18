// Crowdsale.sol
// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;
 
import "./ERC20Token.sol";
 
contract Crowdsale {   
   uint public rate = 200; // le taux à utiliser
   ERC20Token public token;
  
   constructor(uint256 initialSupply) {
       token = new ERC20Token(initialSupply);
   }
}
