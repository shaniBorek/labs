//SPDX-Licenes-Identifier: MIT
pragma solidity ^0.8.20;
import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";
import "@hack/stake/stake.sol";
contract TestStake is Test{
    Stake stake;
    address person1;
    address person2;
    address person3;
    // mapping(address=>uint) stakedAmounts;
    function setUp() public {
        stake = new Stake();
        person1 = address(123);
        person2 = address(456);
        person3 = address(789);
        console.log(stake.owner());
        // stakedAmounts = stake.stakedAmounts();
    }
    function testStake() public  {
        vm.startPrank(person1);
        vm.deal(person1, 11000);
        vm.warp(1735689600);
        uint prevBlPerson1 = address(person1).balance;
        uint prevBalance = address(stake).balance;
        uint preveTotalStake = stake.totalStaked();
        stake.stake{value: 5000}();
        console.log(stake.beginDates(person1));
        assertEq(stake.stakedAmounts(person1),5000);
        assertEq(stake.beginDates(person1)/60/60/24, block.timestamp/60/60/24);
        assertEq(stake.totalStaked() , preveTotalStake + 5000);
        assertEq(prevBlPerson1 - 5000, person1.balance);
        assertEq(prevBalance +5000 , address(stake).balance);
        vm.stopPrank();

    }

    function teststakeFall() public {
        //vm.startPrank(person1)
        vm.expectRevert("must be positive amount");
        stake.stake{value: 0}();
        console.log("gggggggggggggg");
        
    }

    function testStakFallNoMoney() public {
       vm.startPrank(person1);
        vm.deal(person1, 100000);
        vm.warp(1735689600);
        console.log("p",person1.balance);
        uint prevBlPerson1 = address(person1).balance;
        uint prevBalance = address(stake).balance;
        uint preveTotalStake = stake.totalStaked();
        //vm.expectRevert("no money");
        stake.stake{value: 5000}();
        console.log(stake.beginDates(person1));
        assertEq(stake.stakedAmounts(person1),5000);
        assertEq(stake.beginDates(person1)/60/60/24, block.timestamp/60/60/24);
        assertEq(stake.totalStaked() , preveTotalStake + 5000);
        assertEq(prevBlPerson1 - 5000, person1.balance);
        assertEq(prevBalance +5000 , address(stake).balance);
        console.log("p",person1.balance);
        vm.stopPrank();


    }



    function testWithDraw() public {
        uint beginDate =  1735689600;
        vm.warp(beginDate);
        vm.startPrank(person1);
        vm.deal(person1, 100000);
        
       // vm.warp(beginDate);
        stake.stake{value:10000}();
        vm.stopPrank();
        vm.startPrank(person2);
        vm.deal(person2, 100000);
        stake.stake{value:5000}();
        vm.stopPrank();
        vm.startPrank(person3);
        vm.deal(person3, 100000);
        stake.stake{value:5000}();
         uint prevBl = person3.balance;
        vm.warp(beginDate+8*24*60*60);
        stake.withdraw();
        console.log("person1" , person1.balance);
        console.log("person2",person2.balance);
        console.log("person3",person3.balance);
        assertEq(person3.balance , prevBl+5000 +250000);
        

    }
}





