//SPDX-Licens-Identifer: MIT
pragma solidity ^0.8.19;

contract HelloworoldV1{
    string public text = "hello world";

    function setText(string memory _text) public {
        text = _text;
    }
}