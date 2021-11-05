pragma solidity 0.8.9;

// Mauvais
contract Vulnerable {
    function withdraw(uint256 amount) external {
        // This forwards 2300 gas, which may not be enough if the recipient
        // is a contract and gas costs change.
        payable(msg.sender).transfer(amount);
    }
}

// Bon
contract Fixed {
    function withdraw(uint256 amount) external {
        // This forwards all available gas. Be sure to check the return value!
        (bool success, ) = payable(msg.sender).call{value:amount}("");
        require(success, "Transfer failed.");
    }
}