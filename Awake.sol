//SPDX-License-Identifier: GPL-3.

pragma solidity >= 0.7.0 < 0.9.0;

//The subject of the contract : An attendance simulator

contract Awake{
    //state variables
    address owner;
    struct Member{
        bool isMember;
        bool isAWake;
        bool isPaid;
    }
    mapping(address => Member) Members;
    uint8 memberCount;
    uint8 awakeCount;
    uint256 share;
    
    //events
    event successfulSubmission(address To, uint amount, string message);

    //constructor
    constructor() {
        owner = msg.sender;
    }

    //functions
    function RegisterMe() public payable{
        require(msg.value == 1e18);
        require(Members[msg.sender].isMember == false);
        Members[msg.sender].isMember = true;
        Members[msg.sender].isAWake = false;
        Members[msg.sender].isPaid = false;
    }

    function IAmAwake() public {
        require(Members[msg.sender].isMember == true);
        require(Members[msg.sender].isAWake == false);
        Members[msg.sender].isAWake = true;
        awakeCount += 1;
    }

    function PayMyAward() public{
        require(Members[msg.sender].isAWake == true);
        require(Members[msg.sender].isPaid == false);

        if(share == 0){
            share = address(this).balance/awakeCount;
        }
        (bool result, ) = msg.sender.call{value : share} ("");
        if(result){
            emit successfulSubmission(msg.sender, share, "Successful");
        }else{
            emit successfulSubmission(msg.sender, share, "Unsuccessful");
        }
    }

    function getBalance() view public returns(uint256){
        return address(this).balance;
    }
}