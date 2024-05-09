//SPDX-Licenes-Identifir: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/ERC20/IERC20.sol";
contract Trad {
    IERC20 public immutable tokenA;
    IERC20 public immutable tokenB;
    address owner;
    bool oneTime = true;
    uint balanceTokanA;
    uint balanceTokanB;
    uint totalgi;
    mapping(address=> uint ) public Liquidity;
    constructor (address ta ,address tb) {
        owner = msg.sender;
        tokenA = IERC20(ta);
        tokenB =IERC20(tb);

        
    }

    modifier onlyOwner() {
         require(msg.sender == owner , "only owner can do it");
         _;
    }
    function initialize(uint amountA, uint amountB) external onlyOwner {
        require(!oneTime , "one time only");
        oneTime = false;
        require(amountA>0&& amountB>0 , " must be positive amount");
        balanceTokanA = amountA;
        balanceTokanB = amountB;


    }

    function price() public{

    }

    function tradeAToB() public {

    }
    function tradeBToA() public {

    }
    function addLiquidity()public {

    }

    function removeLiquidity()public {

    }

}