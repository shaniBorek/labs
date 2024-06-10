//SPDX-Licens-Identifier: MIT
pragma solidity ^0.8.19;

contract DateLocations {

    uint[] public arr;
    mapping(uint => address) public map;

     struct MyStract {
        uint foo;
     }

     mapping(uint => MyStract) MyStracts;

    function f() public {
        _f(arr, map, MyStracts[1]);
        MyStract storage mystract = MyStracts[1];
        MyStract memory myMemStract  = MyStract(0);
    }

    function _f(uint[] storage _arr, mapping(uint => address) storage map, MyStract storage _MyStract) internal{
        arr.push();
    }


}