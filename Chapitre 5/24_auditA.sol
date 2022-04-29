// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

contract Crowdsale {
    
  address public owner; // the owner of the contract
  address payable public escrow; // wallet to collect raised ETH
  uint256 public savedBalance; // Total amount raised in ETH
  mapping (address => uint256) public balances; // Balances in incoming Ether
  // Event to record each time Ether is paid out
  event PayEther(
  address indexed _receiver,
  uint256 indexed _value,
  uint256 indexed _timestamp
  );
  // Initialization
  constructor (address payable _escrow) {
      owner = msg.sender;
      // add address of the specific contract
      escrow = _escrow;
  }
   // function to receive ETH
  receive() payable external {
      balances[msg.sender] += msg.value;
      savedBalance += msg.value;
      (bool sent,) = escrow.call{value:msg.value}("");
	  require(sent, "Failed to send ETH");
      emit PayEther(escrow, msg.value, block.timestamp);
  }
   // refund investisor
   //to refund investor, escrow SC needs to refund before calling this function
  function withdrawPayments() public{
      address payable payee = payable(msg.sender);
      uint256 payment = balances[payee];
      require(payment != 0);
    
      savedBalance -= payment;
      balances[payee] = 0;
    
      (bool sent,) = payee.call{value:payment}("");
	  require(sent, "Failed to send ETH");
      emit PayEther(payee, payment, block.timestamp);
  }
}