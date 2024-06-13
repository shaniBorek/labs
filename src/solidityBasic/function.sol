//SPDX-Licens-Identifier: MIT
pragma solidity ^0.8.19;

contract Funcions {
    function returnMany() public pure returns(uint , bool, uint) {
        return(1, true, 4);
    }

    function named() public pure returns(uint x, bool b, uint y) {
        return(1, true, 3);
    }

    function assigned() public pure returns(uint x , bool b, uint y){
        x = 1;
        b = true;
        y = 3;
    }

    function destructuringAssignments() public pure 
    returns(uint, bool, uint, uint, uint) {
        (uint x, bool b, uint y) = returnMany();
        (uint c,,uint v) = named();
        return(x,b,y,c,v);
    }
    uint[] public arr;

    function arrayInput() public pure returns(uint[] memory arr) {
        return arr;
    }



}

contract xyz {
    function some(uint a, uint b,uint c) public pure returns(uint ){
      
    }

    function callFunc() external pure returns(uint) {
        return some(1,2,3);
    }
}