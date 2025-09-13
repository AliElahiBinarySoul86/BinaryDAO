// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BinaryDAO {
    struct Proposal {
        uint256 id;
        string description;
        uint256 voteCount;
        bool executed;
    }

    address public admin;
    uint256 public proposalCounter;
    mapping(uint256 => Proposal) public proposals;
    mapping(address => mapping(uint256 => bool)) public hasVoted;

    event ProposalCreated(uint256 id, string description);
    event Voted(address voter, uint256 proposalId);
    event ProposalExecuted(uint256 proposalId);

    constructor() {
        admin = msg.sender;
        proposalCounter = 0;
    }

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can perform this action");
        _;
    }

    function createProposal(string memory _description) public onlyAdmin {
        proposals[proposalCounter] = Proposal({
            id: proposalCounter,
            description: _description,
            voteCount: 0,
            executed: false
        });

        emit ProposalCreated(proposalCounter, _description);
        proposalCounter++;
    }

    function vote(uint256 _proposalId) public {
        require(_proposalId < proposalCounter, "Proposal does not exist");
        require(!hasVoted[msg.sender][_proposalId], "Already voted");

        proposals[_proposalId].voteCount++;
        hasVoted[msg.sender][_proposalId] = true;

        emit Voted(msg.sender, _proposalId);
    }

    function executeProposal(uint256 _proposalId) public onlyAdmin {
        Proposal storage proposal = proposals[_proposalId];
        require(!proposal.executed, "Proposal already executed");
        require(proposal.voteCount > 0, "Not enough votes");

        proposal.executed = true;
        emit ProposalExecuted(_proposalId);
    }

    function getProposal(uint256 _proposalId) public view returns (
        string memory description,
        uint256 voteCount,
        bool executed
    ) {
        Proposal memory p = proposals[_proposalId];
        return (p.description, p.voteCount, p.executed);
    }
}