pragma solidity 0.5.16;

//The subject of the contract : Voting on the issue

contract Ballot{

    //state variables
    struct Voter{
        bool vote;
        uint8 proposalID;
        uint8 weight;
    }

    struct Proposal{
        uint8 voteCount;
    }

    Proposal[] Proposals;
    uint8[] winnerArray;
    address chairPerson;

    mapping(address => Voter) Voters;

    //events
    event registered(string message,address who_registerd);

    //constructor
    constructor (uint8 proposalCnt) public {
        chairPerson = msg.sender;
        Proposals.length = proposalCnt;
        Voters[chairPerson].weight = 2;
    }


    //functions
    function register(address registerAddress) public{
        require(chairPerson == msg.sender);
        require(Voters[registerAddress].vote == false);
        Voters[registerAddress].weight = 1;
        Voters[registerAddress].vote = false;
        emit registered("Are you registerd",registerAddress);
    }

    function vote(uint8 proposalID) public{
        require(Voters[msg.sender].vote == false); 
        require(proposalID < Proposals.length);
        Voters[msg.sender].vote = true;
        Proposals[proposalID].voteCount += Voters[msg.sender].weight;
    }

   function winningProposal () public view returns(uint8 winner_){
        uint8 winner = 0 ;
        for(uint8 i=0; i < Proposals.length; i++){
            if(Proposals[i].voteCount > winner){
                winner = Proposals[i].voteCount;
                winner_ = i;
            }   
        }    
    }
}