//SPDX-Licens-Identifier: MIT
pragma solidity ^0.8.19;

contract Modifier {
    address public owner;
    uint public x = 0;
    bool public locked;
    constructor (){
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "not owner");
        _;
    }

    modifier validAddress(address addr) {
        require(addr != address(0));
        _;
    }

    function changeOwner(address addr) public onlyOwner validAddress(addr) {
        owner = addr;
    }

    modifier noReentrancy() {
        require(!locked, "no");
        locked =true;
        _;
        locked = false;
    }

    function decriment(uint i ) public noReentrancy {
        x -= i;
        if(i >1)
        {
            decriment( i - 1);
        }
    }

}