 //SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
//import "../../lib/openzeppelin-contracts/contracts/token/ERC20"
import "forge-std/console.sol";
import "@openzeppelin/ERC20/ERC20.sol";
//import "../../lib/solmate/src/tokens/ERC20.sol";
contract Stake is ERC20 {
    address public owner;
    // ERC20 public immutable erc20;
    uint public totalReward;
    uint public totalStaked;
    uint WAD =10**18;
    mapping(address=>uint) public stakedAmounts;
    mapping(address=>uint) public beginDates;
    constructor() ERC20('COIN', 'CN') {
        totalReward = 1000000;
        owner = msg.sender;
        // erc20 = new ERC20('COIN', 'CN',18);
        // erc20.
        //payable(address(this)).transfer(totalReward);
        _mint(address(this), totalReward);
        
           console.log("this" ,balanceOf(address(this)));
        // address(this).balance+=1000;??????????
    }

    function mint(address to ,uint amount) public{
        _mint(to, amount);
    }

    receive() external payable {
       // require(balanceOf(person1 , 100000);msg.sender)>=msg.value, "not enough money");
    }
    function stake() external payable{
        require(msg.value>0, "must be positive amount");
        console.log(balanceOf(msg.sender));
        console.log("msg.value",msg.value);
        require(balanceOf(msg.sender) >= msg.value  ,"no money");
        stakedAmounts[msg.sender] += msg.value;
        beginDates[msg.sender] = block.timestamp;
        totalStaked+=msg.value;
        transfer(address(this),msg.value);
        //payable(address(this)).transfer(msg.value);
        console.log(balanceOf(msg.sender));
    }
    function withdraw() external {
        require(stakedAmounts[msg.sender]>0,"you didn't stake anything");
        uint beginDate = beginDates[msg.sender];
        uint dayPassed = (block.timestamp-beginDate)/60/60/24;
        require(dayPassed >= 7, "Your money is still locked.");
        uint reward = totalReward * ( stakedAmounts[msg.sender]*WAD/totalStaked)/WAD;
        
        console.log(reward);
         console.log("this" ,balanceOf(address(this)));
        _mint(address(this), reward);
        _approve(address(this), msg.sender,stakedAmounts[msg.sender]+reward);
        transferFrom(address(this), msg.sender,stakedAmounts[msg.sender]+reward);
        stakedAmounts[msg.sender] = 0;
        beginDates[msg.sender] = 0;
        //payable(msg.sender).transfer(stakedAmounts[msg.sender]+reward);
        
    }
    function getBalance() public returns (uint) {
        return balanceOf(address(this));
    }
    function stakedAmount() public returns (uint) {
        return stakedAmounts[msg.sender];
    }
}
