//SPDX-License-Identifier: GPL-3.int208

pragma solidity >= 0.7.0 <0.9.0;

library SafeMAth {
    function add(uint x, uint y) internal pure returns(uint){
        uint z = x + y;
        require(z >= x, "uint overflow");
        return z;
    }
}

contract TestLib {

    //using SafeMAth for uint;

    function testadd(uint x, uint y) public pure returns(uint){
        return SafeMAth.add(x,y);
    }
}