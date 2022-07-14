//SPDX-License-Identifier: GPL-3.

pragma solidity >= 0.7.0 < 0.9.0;

//The subject of the contract : Simulator for sale at the highest price

contract Auction{
    //state variables
    address private beneficiary;
    uint public auctionStartTime;
    uint public biddingEndTime;

    address highestBidder;
    uint highestBid;

    mapping (address => uint) pendingReturns;

    bool ended = false;

    //events
    event highestBid_Increased(address bidder, uint amount);
    event auction_Ended(address winner, uint amount);

    //constructor
    constructor(address _beneficiary, uint _biddingEndTime){
        beneficiary = _beneficiary;
        auctionStartTime = block.timestamp;
        biddingEndTime = _biddingEndTime + auctionStartTime;
    }


    //modifiers
    modifier haveTime(){
        require(block.timestamp < biddingEndTime,"Oops! Bid time is ended");
        _;
    }

    modifier isHighstBid(){
        pendingReturns[msg.sender] += msg.value;
        require(msg.value > highestBid,"Youe offer is less than the highest bid");
        _;
    }

    modifier canWithdraw(){
        require(pendingReturns[msg.sender] > 0,"An amount is less than zero");
        require(msg.sender != highestBidder);
        _;
    }

    modifier timeEnded(){
        require(block.timestamp > biddingEndTime);
        _;
    }

    modifier auctionStatus(){
        require(!ended);
        _;
    }

    //functions
    function bid() public payable haveTime isHighstBid{
        highestBidder = msg.sender;
        highestBid = msg.value;

        emit highestBid_Increased(msg.sender, msg.value);
    }


    function withdraw()public payable canWithdraw returns(bool){
        uint amount = pendingReturns[msg.sender];
        bool result = payable(msg.sender).send(amount);
        if(result){
            pendingReturns[msg.sender] = 0 ;
            return true;
        }else{
            return false;
        }
    }

    function auctionEnded() public timeEnded auctionStatus{
        ended = true;
        emit auction_Ended(highestBidder, highestBid);
    } 


}