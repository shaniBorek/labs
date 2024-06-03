// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
import "@openzeppelin/ERC20/IERC20.sol";
contract amountDivision {
    address payable owner;
    uint WAD =10**18;
    constructor(){
        owner = payable(msg.sender);
    }

    receive() external payable {}

    function divid(address payable[] calldata  walletsList  ) external payable{
        require(owner == msg.sender, "only owner");
        require(walletsList.length > 0, "no wallet walletsListdress");
        require(msg.value > 0 , "must be biger then 0");
        
        uint sum =  msg.value / walletsList.length;
        for(uint i = 0 ; i < walletsList.length; i++ ){
            payable(walletsList[i]).transfer(sum);
        }


    }
}