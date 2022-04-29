// Bank.sol
// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;
 
contract Bank {
   mapping (address => uint) private _balances;
 
   function deposit(uint _amount) public{
       _balances[msg.sender] += _amount;
   }
   function transfer(address _recipient, uint _amount) public{
       require(_recipient != address(0), "You cannot transfer to the address zero");
       require(_balances[msg.sender] >= _amount, "You have not enough balance");
       _balances[_recipient] += _amount;
       _balances[msg.sender] -= _amount;
   }
   function balanceOf(address _address) public view returns (uint){
       return _balances[_address];
   }
}
