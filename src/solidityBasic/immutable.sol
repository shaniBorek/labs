// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
contract Immutable {
    address public immutable MY_ADDRESS;
    uint public immutable MY_UINT;
    constructor(uint256 _myuint) {
        MY_ADDRESS = msg.sender;
        MY_UINT = _myuint;
    } 

}

