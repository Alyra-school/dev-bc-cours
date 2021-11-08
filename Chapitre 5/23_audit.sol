pragma solidity ^0.5.12;
 
contract Crowdsale {
   using SafeMath for uint256;
 
   address public owner; // the owner of the contract
   address public escrow; // wallet to collect raised ETH
   uint256 public savedBalance = 0; // Total amount raised in ETH
   mapping (address => uint256) public balances; // Balances in incoming Ether
 
   // Initialization
   function Crowdsale(address _escrow) {
       owner = tx.origin;
       // add address of the specific contract
       escrow = _escrow;
   }
  
   // function to receive ETH
   function() public {
       balances[msg.sender] += msg.value;
       savedBalance += msg.value;
       escrow.send(msg.value);
   }
  
   // refund investisor
   function withdrawPayments() public{
       address payee = msg.sender;
       uint256 payment = balances[payee];
 
       payee.send(payment);
 
       savedBalance -= payment;
       balances[payee] = 0;
   }
}
