// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.12;

// The owner can deposit 1 ETH whenever he wants.
// He can only withdraw when the deposited amount reaches 10 ETH.
contract Bank {

    address owner;

    // Set msg.sender as owner
    constructor() {
        owner = msg.sender;
    }

    // Deposit 1 ETH in the smart contract
    function deposit() public payable {
        require(msg.sender == owner);
				require(msg.value == 1 ether);
				require(address(this).balance <= 10 ether);
    }

    // Withdraw the entire smart contract balance
    function withdrawAll() public {
        require(msg.sender == owner);
				require(address(this).balance == 10 ether);
        payable(owner).send(address(this).balance);
    }
}