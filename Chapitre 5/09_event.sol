pragma solidity 0.8.9;

contract Charity {
    mapping(address => uint) balances;

    function donate() payable public {
        balances[msg.sender] += msg.value;
    }
}

contract Game {
    function buyCoins(Charity charity) payable public {
        // 5% goes to charity
        charity.donate{value:msg.value / 20}();
    }
}