//SPDX-Licens-Identifier: MIT
pragma solidity ^0.8.19;

contract IfEls{
    function foo(uint num) public pure returns(uint){
        if(num < 10) {
            return 0;
        }
        else if(num < 20){
            return 1;
        }
        else {
            return 2;
        }
    }

    function ternary(uint x) public pure returns(uint) {
        return x < 10 ? 1 : 2;
    }
}