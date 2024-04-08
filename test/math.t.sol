//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import "../../math/DSMath.sol";
import "forge-std/console.sol";
import "forge-std/Test.sol";
contract Math is Test ,DSMath{
    function setUp() public{}
    function testAdd() public {
       uint a = 2;
       uint b = 1000;
       uint mul1 = mul(a, WAD);
       uint  c = mul1 / b;

        console.log("cccccccccccccc",c);
    }
  

}