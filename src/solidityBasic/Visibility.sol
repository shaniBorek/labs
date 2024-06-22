//SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract Base{
    function privateFunc() private pure returns(string memory){
        return "private function caled";
    }
    function testPrivet() public pure returns(string memory){
        privateFunc();
    }

    function internalfunc() internal pure  returns(string memory){
        return "internal func";
    }

    function testInternal() public pure virtual returns(string memory){
        internalfunc();
    }

    function publicFunc() public pure returns(string memory){
        return "public func";
    }

    function externalfunc() external pure returns(string memory){
        return "external func";
    }
     string private privateVar = "my private variable";
    string internal internalVar = "my internal variable";
    string public publicVar = "my public variable";
}

contract child is Base {
    function testInternal() public pure override returns(string memory){
        return internalfunc();
    }
}