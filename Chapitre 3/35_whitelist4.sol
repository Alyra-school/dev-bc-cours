// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.9;
 
contract Whitelist {
   mapping(address=> bool) whitelist;
   event Authorized(address _address); // Event

// pour initialiser le contrat avec le deployeur comme premier membre whitelisté:
constructor() {
  whitelist[msg.sender]= true;
}
 
   function authorize(address _address) public {
       require (check(), "you are not authorized");
       whitelist[_address] = true;
       emit Authorized(_address); // Triggering event
   }

   function check() private view returns (bool){
       if (whitelist[msg.sender]==true){
           return true;
       } else { 
           return false;
       }
   }
}
