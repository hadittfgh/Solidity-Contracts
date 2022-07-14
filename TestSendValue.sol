//SPDX-License-Identifier: GPL-3.

pragma solidity >= 0.7.0 < 0.9.0;

contract Mony{
    address public owner;

    string public accType;

    constructor() payable{
        owner = msg.sender;
    }

    modifier onlyOwner(){
        require(owner == msg.sender);
        _;
    }

    function sendCall(address payable To, uint amount) external onlyOwner{

        if(address(this).balance <= 1){
            revert("The Balance is less");
        }

        (bool result, ) = To.call{value : amount} ("");
        require(result, "Transfer Failed");

        assert(address(this).balance > 0);
    } 

    function getBalance() public view returns(uint){
        return address(this).balance;
    }

    function contractOrAcount(address who)public{
        (bool result, ) = who.call("");
        if(result){
            accType = "Acount";
        }else{
            accType = "Contract";
        }
    }

    function getAccType()public view returns(string memory){
        return accType;
    }

    function destruct() public onlyOwner{
        selfdestruct(payable(owner));
    }
}