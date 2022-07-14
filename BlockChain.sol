// SPDX-License-Identifier: GPL-3.

pragma solidity >= 0.7.0 < 0.9.0;

contract BlockChain{
    //getBlockDifficulty
    function getBlockDifficulty() public view returns(uint){
        return block.difficulty;
    }
    //getBlockTimestamp
    function getBlockTimestamp() public view returns(uint){
        return block.timestamp;
    }
    //getBlockNumber
    function getBlockNumber() public view returns(uint){
        return block.number;
    }
    //getBlockHash
    function getBlockHash() public view returns(bytes32){
        return blockhash(block.number + 1);
    }
    //getBlockMiner
    function getBlockMiner() public view returns(address payable){
        return block.coinbase;
    }
    //getBlockBaseFee
    function getBlockBaseFee() public view returns(uint){
        return block.basefee;
    }
    //getBlockGasLimit
    function getBlockGasLimit() public view returns(uint){
        return block.gaslimit;
    }
    //getRemainingGas
    function getRemainingGas() public view returns(uint){
        return gasleft();
    }
    //getMessageData
    function getMessageData() public pure returns(bytes calldata){
        return msg.data;
    }
    //getMessageSender
    function getMessageSender() public view returns(address){
        return msg.sender;
    }
    //getMessageSign
    function getMessageSign() public pure returns(bytes4){
        return msg.sig;
    }
    //getMessageValue
    function getMessageValue() public payable returns(uint){
        return msg.value;
    }
    //getGasPrice
    function getGasPrice() public payable returns(uint){
        return tx.gasprice;
    }
    //getTXSender
    function getTXSender() public view returns(address){
        return tx.origin;
    }
    //abiEndPack
    function abiEndPack(uint inputA) public pure returns(bytes memory){
        return abi.encodePacked(inputA);
    }
    //hashByKeccak256
    function hashByKeccak256(string memory ValToHash) public pure returns(bytes32){
        return bytes32(keccak256(abi.encodePacked(ValToHash)));
    }
}