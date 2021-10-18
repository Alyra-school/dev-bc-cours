// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;
 
contract Whitelist {
  struct Person { // Structure de données
      string name;
      uint age;  
  }
 
  function createPerson(string memory _name, uint _age) public {
       Person memory person = Person(_name, _age);
  }
}
