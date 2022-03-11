// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.12;

// You can store ETH in this contract and redeem them.
contract VaultFixed {
    mapping(address => uint) public balances;

    /// @dev Store ETH in the contract.
    function store() public payable {
        balances[msg.sender]+=msg.value;
    }
    
    /// @dev Redeem your ETH.
    function redeem() public {
        uint toSend = balances[msg.sender];
        balances[msg.sender]=0;
				msg.sender.call{ value: toSend }("");
    }
}