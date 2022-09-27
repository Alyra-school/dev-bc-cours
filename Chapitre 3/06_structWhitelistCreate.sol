// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.9;
contract Whitelist {
   struct Person { // Structure de données
       string name;
       uint age;   
   }
   
   Person public moi;

    function modifyPerson(string memory _name, uint _age) public {
      moi.name = _name;
      moi.age = _age;
  }
}
