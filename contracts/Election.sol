// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.8.0;

contract Election {

    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }

    mapping(uint => Candidate) public candidates;  // for storing candidates
    mapping(address => bool) public voters; // for storing data if a voter has voted
    
    uint public candidatesCount; // number of candidates
    // emit event for refreshing page
    event votedEvent(   
        uint indexed candidateId
    );

    // when contract is deployed it will create two candidates
    constructor () public {
        addCandidate("candidate1");
        addCandidate("candidate2");
    }

    // to add a candidate
    function addCandidate(string memory _name) private {
        candidatesCount++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
    }

    // to vote for a candidate
    function vote(uint _candidateId) public { 
        require(voters[msg.sender] == false); // check if the voter has already voted
        require(_candidateId <= candidatesCount && _candidateId > 0); // check if the candidate id is valid
        voters[msg.sender] = true; // set the voter to voted

        candidates[_candidateId].voteCount++; // increment the vote count of candidate
        emit votedEvent(_candidateId); // emit the event
    }

}
