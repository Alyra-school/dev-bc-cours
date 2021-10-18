// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;
 
import "https://github.com/OpenZeppelin/openzeppelin-contracts/contracts/access/Ownable.sol";
 
contract Voting is Ownable{
   enum WorkflowStatus { RegisteringVoters, ProposalsRegistrationStarted, ProposalsRegistrationEnded, VotingSessionStarted, VotingSessionEnded, VotesTallied }
  
   struct Voter {
       bool isRegistered;
       bool hasVoted; 
       uint votedProposalId;  
   }
 
   struct Proposal {
       string description;  
       uint voteCount;
   }
 
   WorkflowStatus public workflowStatus = WorkflowStatus.RegisteringVoters;
   mapping(address => Voter) public voters;
   Proposal[] public proposals;
   uint private winningProposalId;
  
   event VoterRegistered(address voterAddress);
   event WorkflowStatusChange(WorkflowStatus previousStatus, WorkflowStatus newStatus);
   event ProposalRegistered(uint proposalId);
   event Voted (address voter, uint proposalId);
  
  
   modifier onlyRegisteredVoter() {
       require(voters[msg.sender].isRegistered, "the caller of this function must be a registered voter");
       _;
   }
  
   modifier onlyDuringVotersRegistration() {
       require(workflowStatus == WorkflowStatus.RegisteringVoters, "this function can be called only before proposals registration has started");
       _;
   }
  
   modifier onlyDuringProposalsRegistration() {
       require(workflowStatus == WorkflowStatus.ProposalsRegistrationStarted, "this function can be called only during proposals registration");
       _;
   }
  
   modifier onlyAfterProposalsRegistration() {
       require(workflowStatus == WorkflowStatus.ProposalsRegistrationEnded, "this function can be called only after proposals registration has ended");
       _;
   }
  
   modifier onlyDuringVotingSession() {
       require(workflowStatus == WorkflowStatus.VotingSessionStarted, "this function can be called only during the voting session");
       _;
   }
  
   modifier onlyAfterVotingSession() {
       require(workflowStatus == WorkflowStatus.VotingSessionEnded, "this function can be called only after the voting session has ended");
       _;
   }
  
   modifier onlyAfterVotesTallied() {
       require(workflowStatus == WorkflowStatus.VotesTallied, "this function can be called only after votes have been tallied");
       _;
   }
  
   function registerVoter(address _voterAddress) public onlyOwner onlyDuringVotersRegistration {
       require(!voters[_voterAddress].isRegistered, "the voter is already registered");
      
       voters[_voterAddress].isRegistered = true;
       voters[_voterAddress].hasVoted = false;
       voters[_voterAddress].votedProposalId = 0;
      
       emit VoterRegistered(_voterAddress);
   }
  
   function startProposalsRegistration() public onlyOwner onlyDuringVotersRegistration {
       workflowStatus = WorkflowStatus.ProposalsRegistrationStarted;
      
       emit WorkflowStatusChange(WorkflowStatus.RegisteringVoters, workflowStatus);
   }
  
   function endProposalsRegistration() public onlyOwner onlyDuringProposalsRegistration {
       workflowStatus = WorkflowStatus.ProposalsRegistrationEnded;
 
       emit WorkflowStatusChange(WorkflowStatus.ProposalsRegistrationStarted, workflowStatus);
   }
  
   function registerProposal(string memory proposalDescription) public onlyRegisteredVoter onlyDuringProposalsRegistration {
       proposals.push(Proposal({ description: proposalDescription, voteCount: 0 }));
      
       emit ProposalRegistered(proposals.length - 1);
   }
  
   function getProposalsNumber() public view returns (uint) {
       return proposals.length;
   }
   
   function getProposalDescription(uint index) public view returns (string memory) {
       return proposals[index].description;
   }   
 
   function startVotingSession() public onlyOwner onlyAfterProposalsRegistration {
       workflowStatus = WorkflowStatus.VotingSessionStarted;
      
       emit WorkflowStatusChange(WorkflowStatus.ProposalsRegistrationEnded, workflowStatus);
   }
  
   function endVotingSession() public onlyOwner onlyDuringVotingSession {
       workflowStatus = WorkflowStatus.VotingSessionEnded;
      
       emit WorkflowStatusChange(WorkflowStatus.VotingSessionStarted, workflowStatus);       
   }
  
   function vote(uint proposalId) onlyRegisteredVoter onlyDuringVotingSession public {
       require(!voters[msg.sender].hasVoted, "the caller has already voted");
 
       voters[msg.sender].hasVoted = true;
       voters[msg.sender].votedProposalId = proposalId;
 
       proposals[proposalId].voteCount += 1;
       
       if (proposals[proposalId].voteCount > proposals[winningProposalId].voteCount) {
            winningProposalId = proposalId;
       }
 
       emit Voted(msg.sender, proposalId);
   }
 
   function tallyVotes() onlyOwner onlyAfterVotingSession public {
       workflowStatus = WorkflowStatus.VotesTallied;
      
       emit WorkflowStatusChange(WorkflowStatus.VotingSessionEnded, workflowStatus);    
   }
  
   function getWinningProposalId() onlyAfterVotesTallied public view returns (uint) {
       return winningProposalId;
   }
  
   function getWinningProposalDescription() onlyAfterVotesTallied public view returns (string memory) {
       return proposals[winningProposalId].description;
   } 
  
   function getWinningProposaVoteCounts() onlyAfterVotesTallied public view returns (uint) {
       return proposals[winningProposalId].voteCount;
   }  
  
   function isRegisteredVoter(address _voterAddress) public view returns (bool) {
       return voters[_voterAddress].isRegistered;
   }
   
   function isAdministrator(address _address) public view returns (bool) {
       return _address == owner();
   }    
   
   function getWorkflowStatus() public view returns (WorkflowStatus) {
       return workflowStatus;      
   }
}
