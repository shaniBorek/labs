//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import "../../math/DSMath.sol";
import "forge-std/console.sol";
import "forge-std/Test.sol";
contract Math is Test ,DSMath{
    function setUp() public{}
    function testAdd() view public {
       uint a = 2;
       uint b = 1000;
       uint mul1 = mul(a, WAD);
       uint  c = mul1 / b;
       uint z = add(c,mul(9,WAD));
       uint z1 = mul(z ,c)/WAD;

        console.log("c",c);
        console.log(mul(c,7));
        console.log(c/7);
        console.log("zz" , z);
        console.log("z1" , z1);

        
    }
  

}