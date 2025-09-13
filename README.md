# 🗳️ BinaryDAO

BinaryDAO is a decentralized voting smart contract written in Solidity.  
This project is developed by Binary Soul, a Solidity developer duo focused on Web3 innovation.

## 🔧 Features
- Create proposals with descriptions
- Vote on proposals (one vote per address)
- Execute proposals after voting ends
- Track proposal status and vote count

## 🚀 How to Deploy

1. Copy BinaryDAO.sol into [Remix IDE](https://remix.ethereum.org)  
2. Compile with Solidity version ^0.8.0  
3. Deploy the contract  
4. Use createProposal(string description) to submit new proposals  
5. Use vote(uint proposalId) to cast votes  
6. Use executeProposal(uint proposalId) to finalize decisions
