// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract SimpleStoreg {
    uint public num;

    function set(uint _num) public {
        num = _num;
    }

    function get() public returns(uint) {
        return num;
    }
}