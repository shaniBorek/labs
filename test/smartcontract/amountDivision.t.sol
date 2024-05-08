// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import "@openzeppelin/ERC20/IERC20.sol";
import "@hack/smartContract/amountDivision.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";
contract testAmountDivisin is Test{
    amountDivision  aD;
    address payable[] walletAddress;
    function setUp() public{
        aD = new amountDivision();
        walletAddress.push(payable(0x074AC318E0f004146dbf4D3CA59d00b96a100100)) ;
         walletAddress.push(payable(0x68BF2f4E4091C29dFa88B2c8bCBB65f00A63CE04));
        //  walletAddress[2] = 0xFc9ECA65d2BD19991F46ad73570920B2a7a23831;
        //  walletAddress[3] = 0x11059Fa68a9a49D683665AafDc93483d74544A47;
        //  walletAddress[4] = 0x7F4Bf8251F5003bB60cb482c0a59473E1C4428d4;
    }

    function testDivid() public {
        vm.deal(payable(aD) ,10 ether);
        vm.startPrank(address(this));
        uint first = address(walletAddress[0]).balance;
        uint seconed = address(walletAddress[1]).balance;
        aD.divid{value: 10 ether}( walletAddress );

        assertEq(address(walletAddress[0]).balance , first + 5 ether );
    }
}