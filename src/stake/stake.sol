 //SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";

import "forge-std/console.sol";
//import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "../../lib/solmate/src/tokens/ERC20.sol";
contract Stake is ERC20 {
    address public owner;
    // ERC20 public immutable erc20;
    uint public totalReward;
    uint public totalStaked;
    uint WAD =10**18;
    mapping(address=>uint) public stakedAmounts;
    mapping(address=>uint) public beginDates;
    constructor() ERC20('COIN', 'CN',18) {
        totalReward = 1000000;
        owner = msg.sender;
        // erc20 = new ERC20('COIN', 'CN',18);
        // erc20.
        _mint(address(this), totalReward);
           console.log("this" ,address(this).balance);
        // address(this).balance+=1000;??????????
    }
    receive() external payable {
        require(msg.sender.balance>=msg.value, "not enough money");
    }
    function stake() external payable{
        console.log(msg.sender.balance);
        console.log(msg.value);
        console.log(msg.sender.balance - msg.value);
        require(msg.value>0, "must be positive amount");
        require(msg.sender.balance - msg.value >= 0 ,"no money");
        stakedAmounts[msg.sender] += msg.value;
        beginDates[msg.sender] = block.timestamp;
        console.log(block.timestamp);
        totalStaked+=msg.value;
        payable(address(this)).transfer(msg.value);
        console.log(msg.sender.balance);
    }
    function withdraw() external {
        require(stakedAmounts[msg.sender]>0,"you didn't stake anything");
        uint beginDate = beginDates[msg.sender];
        uint dayPassed = (block.timestamp-beginDate)/60/60/24;
        require(dayPassed >= 7, string(abi.encodePacked("Your money is still locked.")));
        uint reward = totalReward * ( stakedAmounts[msg.sender]*WAD/totalStaked)/WAD;
        
        console.log(reward);
         console.log("this" ,address(this).balance);
        _mint(address(this), reward);
        payable(msg.sender).transfer(stakedAmounts[msg.sender]+reward);
        
    }
    function getBalance() public returns (uint) {
        return address(this).balance;
    }
    function stakedAmount() public returns (uint) {
        return stakedAmounts[msg.sender];
    }
}
