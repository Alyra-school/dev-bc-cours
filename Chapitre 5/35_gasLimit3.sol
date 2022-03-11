function vote(uint proposalId) public flowStatus(WorkflowStatus.VotingSessionStarted) {
        require(voters[msg.sender].isRegistered, "You are not allowed to vote");
        require(!voters[msg.sender].hasVoted, "You have already voted");
        proposals[proposalId].voteCount += 1;
        voters[msg.sender].hasVoted = true;
        voters[msg.sender].votedProposalId = proposalId;

        if (proposals[proposalId].voteCount > proposals[winningProposalId].voteCount) {
            winningProposalId = proposalId;
        }

        emit Voted(msg.sender, proposalId);
    }