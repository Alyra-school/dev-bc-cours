// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;
 
contract Whitelist {
 struct Person { // Structure de données
     string name;
     uint age; 
 }
 Person[] public persons;
 function add(string memory _name, uint _age) public {
      Person memory person = Person(_name, _age);  // création d'un nouveau objet
      persons.push(person); // Ajout de l'objet "Person" dans le tableau
 }
  function remove() public {
      persons.pop(); // Suppression du dernier objet du tableau
 }
}
