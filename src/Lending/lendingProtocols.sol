// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import "@openzeppelin/ERC20/ERC20.sol";
import "@hack/Lending/mathematics.sol";


contract LedingProtocals is ERC20 ,Mathematics{

    address owner;
    mapping (address => uint) public lendersDai; 
     mapping (address => uint) public lendersEth; 
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
        lendersDai[msg.sender] += amount;
        collateralValue += amount;
        _mint(msg.sender, amount);

    }

    function receiveTheLendingDAY(uint amount) external validAmount(amount){
        require(lendersDai[msg.sender] >= amount, "You did not deposit enough DAI");
        require(bond.balanceOf(msg.sender) >= amount, "You dont have enough bond");
        _burn(msg.sender, amount);
        collateralValue -= amount;
        DAI.transfer(msg.sender, amount);
        lendersDai[msg.sender] -= amount;

    }
    function borrow(uint borrowedValue) external validAmount(borrowedValue) payable{
        require(msg.value <= msg.sender.balance, "you dont have enough eth");
        uint borrowLimit = percentage((collateralValue - borrowedValue), maxLTV);
        lendersEth[msg.sender] = msg.value;
        require(borrowLimit <= borrowedValue, "You have a limeted borrow ");
        DAI.transferFrom(address(this), msg.sender, borrowedValue);

    }

    function removeETH(uint amount ) external validAmount(amount){
        require( amount * 3,116 <= lendersDai[msg.sender], "you dont have enough dai");
        payable(address(msg.sender)).transfer(amount);
        lendersDai[msg.sender] -= amount * 3,116 ;
        collateralValue -= amount * 3,116 ;

    }

    function borrowDAI(uint amount) external validAmount(amount){
        require(amount/3,116 >= lendingEth[msg.sender], "you dont have enough eth");
        dai.transferFrom(address(this), msg.sender, amount/3116);
        lendersEth[msg.sender]  -= amount/3116;
        
    }

}