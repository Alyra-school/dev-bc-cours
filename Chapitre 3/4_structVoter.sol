pragma solidity 0.8.9;
 
contract Ballot {
   struct Voter { // Structure de données
       uint weight;
       bool voted;
       address delegate;
       uint vote;
   }
}
