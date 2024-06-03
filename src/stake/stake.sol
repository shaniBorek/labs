 //SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
//import "../../lib/openzeppelin-contracts/contracts/token/ERC20"
import "forge-std/console.sol";
import "@openzeppelin/ERC20/IERC20.sol";
import "../../../new-project/src/MyToken.sol";
//import "../../lib/solmate/src/tokens/ERC20.sol";
contract Stake{
    address public owner;
    MyToken public immutable token;
    uint public totalReward;
    uint public totalStaked;
    uint WAD =10**18;
    mapping(address=>uint) public stakedAmounts;
    mapping(address=>uint) public beginDates;

    constructor(address _token) {
        token = MyToken(_token);
        totalReward = 1000000;
        owner = msg.sender;
        token.mint(address(this), totalReward);
        console.log("this" ,token.balanceOf(address(this)));
    }

    function mint(address to ,uint amount) public{
        token.mint(to, amount);
    }

    receive() external payable {
    //    require(balanceOf(person1)>=msg.value, "not enough money");
    }
    function stake() external payable{
        require(msg.value>0, "must be positive amount");
        console.log(token.balanceOf(msg.sender));
        console.log("msg.value",msg.value);
        require(token.balanceOf(msg.sender) >= msg.value  ,"no money");
        stakedAmounts[msg.sender] += msg.value;
        beginDates[msg.sender] = block.timestamp;
        totalStaked+=msg.value;
        token.transferFrom(msg.sender,address(this),msg.value);
        //payable(address(this)).transfer(msg.value);
        console.log(token.balanceOf(msg.sender));
    }
    function withdraw() external {
        require(stakedAmounts[msg.sender]>0,"you didn't stake anything");
        uint beginDate = beginDates[msg.sender];
        uint dayPassed = (block.timestamp-beginDate)/60/60/24;
        require(dayPassed >= 7, "Your money is still locked.");
        uint reward = totalReward * ( stakedAmounts[msg.sender]*WAD/totalStaked)/WAD;
        
        console.log(reward);
         console.log("this" ,token.balanceOf(address(this)));
        token.mint(address(this), reward);
        // _approve(address(this), msg.sender,stakedAmounts[msg.sender]+reward);
        token.transfer( msg.sender,stakedAmounts[msg.sender]+reward);
        delete stakedAmounts[msg.sender];
        delete beginDates[msg.sender];        
    }
    function getBalance() view public returns (uint) {
        return token.balanceOf(address(this));
    }
    function stakedAmount() view public returns (uint) {
        return stakedAmounts[msg.sender];
    }
}
