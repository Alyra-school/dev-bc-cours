pragma solidity 0.8.9;

// INSECURE
contract Auction {
    address currentLeader;
    uint highestBid;

    function bid() payable public {
        require(msg.value > highestBid);

        require(payable(currentLeader).send(highestBid)); // Refund the old leader, if it fails then revert

        currentLeader = msg.sender;
        highestBid = msg.value;
    }
}