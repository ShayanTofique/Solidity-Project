// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Elections{
    address owner;
    string electionName;
    uint deadline;
    event winner(string election,string winnerCandidate,uint votecount_);
      modifier onlyOnwer{
        require(msg.sender==owner);
        _;
    }
    modifier Deadline{
        require(block.timestamp < deadline,"The voting time has been over now!");
        _;
    }
     struct Candidate{
        string name;
        uint8 voteCount;
    }
    struct Voter{
        bool authorized;
        bool voted;
        uint8 voteIndex;
    }
    Candidate[] public Candidates;
    mapping(address=>Voter) public Voters;
    constructor(string memory _name,string[] memory candidateNames,uint _deadline){
        owner=msg.sender;
        electionName=_name;
        deadline = block.timestamp + _deadline;
        for (uint i = 0; i < candidateNames.length; i++) {
            Candidates.push(Candidate({
                name: candidateNames[i],
                voteCount: 0
            }));
        }
    }
    
    function Authorize(address voter) external onlyOnwer{
        Voters[voter].authorized=true;
    }

    function VOTE(uint _id) external Deadline {
        require(Voters[msg.sender].authorized==true,"you are not eligible for voting");
        require(Voters[msg.sender].voted==false,"you have already voted!");
        Voters[msg.sender].voted=true;
        Candidates[_id].voteCount++;
    }
      function end() onlyOnwer external onlyOnwer{
        require(block.timestamp > deadline);
        emit winner(electionName,Candidates[winningCandidate()].name,Candidates[winningCandidate()].voteCount);
    }

       function winningCandidate() public view onlyOnwer returns (uint WinningCandidate){
        uint winningVoteCount = 0;
        for (uint i = 0; i < Candidates.length; i++) {
            if (Candidates[i].voteCount > winningVoteCount) {
                winningVoteCount = Candidates[i].voteCount;
                WinningCandidate = i;
            }
        }
    }
}