//SPDX-License-Identifier: GPL-3.int208

pragma solidity >= 0.7.0 <0.9.0;

import "./BlockChain.sol";

contract Randommness{
     BlockChain public bc = new BlockChain(); 

     function getRandInt(uint upto) public view returns(uint){
         uint _seed = bc.getBlockTimestamp();
         return uint256(keccak256(abi.encodePacked(bc.getBlockHash, _seed)))%(upto + 1);
     }
}