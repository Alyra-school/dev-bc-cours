// Crowdsale.sol
// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;
 
import "./ERC20Token.sol";
 
contract Crowdsale {  
   uint public rate = 200; // le taux à utiliser
   ERC20Token public token; // L’instance ERC20Token à déployer 
 
   constructor() {
       token = new ERC20Token(); // crée une nouvelle instance du smart       contract ERC20Token ! L’instance ERC20Token déployée sera stockée dans la variable “token” 
   }
}
