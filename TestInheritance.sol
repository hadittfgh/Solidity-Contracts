//SPDX-License-Identifier: GPL-3.

pragma solidity >= 0.7.0 < 0.9.0;

contract A{
    function add(uint x, uint y)public pure virtual returns(uint){
        uint z = x + y;
        return z ;
    }
}

contract B is A{
    function add(uint x, uint y)public pure virtual override returns(uint){
        uint z = x + y;
        if (z < x){
            return 0;
        }
        else{
            return z ;
        }
    }

    function parentAdd(uint x, uint y)public pure virtual returns(uint){
        uint z = super.add(x,y);
        return z;
    }
    
}