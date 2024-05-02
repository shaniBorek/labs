  
//SPDX-Licenes-Identifier: MIT
pragma solidity ^0.8.20;
import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";
import "../../../new-project/src/MyToken.sol";
import "@hack/StakingRewards/StakingRewards.sol";
// import "@hack/stake/stake.sol";
contract TestStake is Test{
    // Stake stake;
    StakingRewards staking;
    MyToken st;
    MyToken rt;
    MyToken token ;
    address person1;
    address person2;
    address person3;
    uint WAD =10**18;
    // mapping(address=>uint) stakedAmounts;
    function setUp() public {
     
        st = new MyToken();
        rt = new MyToken();
        staking =  new StakingRewards(address(st) , address(rt));
        person1 = address(1234);
        st.mint(person1, 10000);
    
    }
    function testStakingRewards() public  {
        vm.startPrank(person1);
        st.approve(address(staking),100);
        staking.stake(100);
        vm.stopPrank();
        vm.warp(1735689600);
       console.log("stakingggg", staking.staked());
        staking.updateRate(1000);

        console.log("rate" , staking.rate());
        console.log("day",staking.duration());
        

    }


}





