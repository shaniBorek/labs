//SPDX-Licenes-Identifier: MIT
pragma solidity ^0.8.20;
import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";
import "@hack/StakingRewards/StakingRewards.sol";
import "../../../new-project/src/MyToken.sol";
contract TestStakingRewards is Test {

    MyToken st;
    MyToken rt;
    address person1;
    address person2;
    address person3;
    StakingRewards stake;
    function setup() public{
       
        st = new MyToken();
        rt = new MyToken();
        stake =  new StakingRewards(address(st) , address(rt));
        rt.mint(address(stake), 1000000);
        st.mint(person1 ,1111);
        st.mint(person2 ,1111);
        st.mint(person3 ,1000);
       
    }

    function testLastTime() public {
        vm.startPrank(person1);
        
        vm.warp(1735689600);
        rt.approve(address(stake),222);
        stake.stake(222);
    } 
}