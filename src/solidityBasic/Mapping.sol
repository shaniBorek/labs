//SPDX-Licens-Identifier: MIT
pragma solidity ^0.8.19;

contract Mapping {
    mapping (address => uint) public MyMap;

    function get(address _addr) public view returns(uint) {
        return MyMap[_addr];
    }

    function set(address _addr, uint i ) public {
        MyMap[_addr] = i;
    }

     function remove(address _addr) public {
        delete MyMap[_addr];
     }
}

contract NestedMapping {
    mapping (address => mapping(uint => bool)) public MyMap;

    function get(address _addr, uint i) public view returns(bool) {

        return MyMap[_addr][i];
    } 

    function set(address _addr, uint i, bool b) public {
        MyMap[_addr][i] = b;
    }

    function remove(address _addr, uint i) public  {
       delete MyMap[_addr][i];
    }
}