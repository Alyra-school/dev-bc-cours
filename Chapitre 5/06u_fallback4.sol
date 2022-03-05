// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.12;

contract Wallet{

	mapping (address=>uint) balances;
	
	event LogBadCall(address user);
	event LogDepot(address user, uint quantity);
	
	function deposit() payable external {
		balances[msg.sender] += msg.value;
		emit LogDepot(msg.sender, msg.value);
	}
	
	fallback() external { emit LogBadCall(msg.sender);}
	
	receive() external payable { emit LogDepot(msg.sender, msg.value);}

}