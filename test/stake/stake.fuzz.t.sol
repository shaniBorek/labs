//SPDX-Licenes-Identifier: MIT
pragma solidity ^0.8.2;
import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";
import "../../../new-project/src/MyToken.sol";
import "@hack/stake/stake.sol";
contract TestFuzzStake is Test {
    Stake stake;
    MyToken token;
    address person1;

    function setUp() public {
        token =new MyToken();
        stake = new Stake(address(token));
        person1 =address(1234);
    }

    function testFuzzStake(uint initialVal, uint amountStake) public {
        vm.startPrank(person1);
          vm.deal(person1, 11000);
        vm.warp(1735689600);
       // Limit the input range manually
        // uint256 limitedValue = value % amountToken; // Limits `value` to be between 0 and 999
        // contract.testFunction(limitedValue);
        vm.assume(initialVal>0 && amountStake>0 );
        vm.assume(initialVal<100000000);
        stake.mint(person1 ,initialVal );
        vm.assume(amountStake <= initialVal);
        console.log("amountStake" , amountStake);
        uint prevBlPerson1 = token.balanceOf(address(person1));
        uint prevBalance = token.balanceOf(address(stake));
        uint preveTotalStake = stake.totalStaked();

        token.approve(address(stake),amountStake);
        stake.stake{value: amountStake}();
        console.log(stake.beginDates(person1));
        assertEq(stake.stakedAmounts(person1),amountStake);
        assertEq(stake.beginDates(person1)/60/60/24, block.timestamp/60/60/24);
        assertEq(stake.totalStaked() , preveTotalStake + amountStake);
        assertEq(prevBlPerson1 - amountStake, token.balanceOf(person1));
        assertEq(prevBalance +amountStake , token.balanceOf(address(stake)));
       
    }

}
