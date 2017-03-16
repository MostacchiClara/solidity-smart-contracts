pragma solidity ^0.4.0;
contract Vote {

    address chairperson;
    Voter[] voters;
    Proposal[]  proposals;

    struct Voter {
        bool voted;
        address addresse;
        uint vote;
    }

    struct Proposal {
        uint voteCount;
        bytes32 name;
    }
    
    function Vote() {
        chairperson = msg.sender;
    }

    // Allow voters to vote, take in argument the proposal
    function letsVote(uint proposal)
    {
        for(uint i = 0; i< voters.length ; i++)
        {
            if(msg.sender == voters[i].addresse)
            {
                if(voters[i].voted) throw;
                voters[i].voted = true;
                proposals[proposal].voteCount += 1;
                voters[i].vote = proposal;
            }
        }
    }

    // Allow to add a new voter to the voters tab this operation can be only
    // perform by the chairman, the voter mustn't being already present in the tab
    // Takes in parameter the address of the voter
    function addVoter(address newVoter) {
        bool present = false;
        if (msg.sender != chairperson)
        {
            throw;
        }
        for(uint i = 0; i< voters.length ; i++)
        {
            if(newVoter == voters[i].addresse)
            {
                present = true ;
            }
        }
        if(!present)
        {
            voters.push(Voter({voted : false, addresse : newVoter, vote : 0 }));
        }

    }

    // Allow to add a new proposal to proposals tab this operation can be only
    // perform by the chairman
    // Takes in parameter the name of the proposal
	
    function addProposal(bytes32 newProposal) {
        bool present = false;
        if (msg.sender != chairperson)
        {
            throw;
        }
        for(uint i = 0; i< proposals.length ; i++)
        {
            if(newProposal == proposals[i].name) throw;
            proposals.push( Proposal({name : newProposal , voteCount : 0 }));
        }
    }

    function winningProposal() constant returns (uint winningProposal)
    {
        if (msg.sender != chairperson) throw;
        else{
            uint winningVoteCount = 0;
            for (uint i = 0; i < proposals.length; i++) {
                
                if (proposals[i].voteCount > winningVoteCount) {
                winningVoteCount = proposals[i].voteCount;
                winningProposal = i;
                }
            }
        }
    }
    
     
    function kill() {
        if (msg.sender == chairperson) {
            suicide(chairperson);
        }else{ throw;}
    }
}
