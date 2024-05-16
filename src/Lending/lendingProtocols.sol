// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import "@openzeppelin/ERC20/ERC20.sol";
import "@hack/Lending/mathematics.sol";


contract LedingProtocals is ERC20 ,Mathematics{

    address owner;
    mapping (address => uint) public lenders; 
    ERC20 DAI;
    ERC20 bond;
    uint maxLTV = 80;
    uint collateralValue = 0;
 
    constructor(address tokenAddress) ERC20("bond", "bnd"){
        DAI = ERC20(tokenAddress);
    }

    modifier validAmount(uint amount){
        require(amount > 0, "unvalid amount");
        _;
    }

    function lendingDAI(uint amount) public validAmount(amount){

        DAI.transferFrom(msg.sender, address(this), amount);
        lenders[msg.sender] += amount;
        collateralValue += amount;
        _mint(msg.sender, amount);

    }

    function receiveTheLendingDAY(uint amount) external validAmount(amount){
        require(lenders[msg.sender] >= amount, "You did not deposit enough DAI");
        require(bond.balanceOf(msg.sender) >= amount, "You dont have enough bond");
        _burn(msg.sender, amount);
        collateralValue -= amount;
        DAI.transfer(msg.sender, amount);
        lenders[msg.sender] -= amount;

    }
    function borrow(uint borrowedValue) external validAmount(borrowedValue) payable{
        require(msg.value <= msg.sender.balance, "you dont have enough eth");
        uint borrowLimit = percentage((collateralValue - borrowedValue), maxLTV);
        require(borrowLimit <= borrowedValue, "You have a limeted borrow ");

    }

}