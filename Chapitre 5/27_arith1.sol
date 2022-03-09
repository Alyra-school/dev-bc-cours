// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

contract Comptes {

  uint8 constant max = 200;
  mapping (address => uint8) comptes;

  function borrow(uint8 _amount) public {
    require (comptes[msg.sender]+_amount <= max, 'tu retires trop');

    (bool sent, ) = msg.sender.call{value: _amount}("");
    require(sent, "Failed to send Ether");      
    
    comptes[msg.sender]+=_amount;

  }

  function refund() payable public{
      require(comptes[msg.sender]-uint8(msg.value)>=0, "tu rends trop");
      comptes[msg.sender]-=uint8(msg.value);
  }

}