//SPDEX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";
import "../../../new-project/src/MyToken.sol";
import "@hack/trading/AMM.sol";
contract TestAmm is Test{
    Amm1 amm;
    MyToken t0;
    MyToken t1;
    address user1;

    function setUp() public {
        t0 = new MyToken();
        t1 = new MyToken();
        amm  = new Amm1(address(t0) ,address(t1));
        user1 = address(1234);
    }

    function testmint() public {
        vm.startPrank(user1);
        // Amm1.mint(user1, 200);
    }

}