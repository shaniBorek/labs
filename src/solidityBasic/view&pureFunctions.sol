//SPDX-Licens-Identifier: MIT
pragma solidity ^0.8.19;
contract viewAndPure {
    uint public x = 1;
    function add(uint y) public view returns(uint){
        return x+y;
    }

    function adddd(uint i, uint y) public pure returns(uint) {
        return i+ y;
    }
}