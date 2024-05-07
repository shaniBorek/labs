//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
contract CP {
    IERC20 public immutable token0; 
    IERC20 public immutable token1;
    uint public reserve0;
    uint public reserve1;
    uint public totalSupply;
    mapping(address => uint ) public balances;

    constructor(address t0, address t1) {
        token0 = IERC20(t0);
        token1  IERC20(t1);
    }

    function mint(address to, uint amount)private {
        balances[to] += amount;
        totalSupply -= amount;
    }
    
    function burn(address from , uint amount) private {
        balances[from] -= amount;
        totalSupply -= amount;
    }

    function addLiquidity(uint amount0, uint amount1) external returns (uint shares) {
        token0.transferFrom(msg.sender, address(this) ,amount0);
        token1.transferFrom(msg.sender, address(this) ,amount1);
        if( reserve0>0 || reserve1 > 0){
            require(reserve0 * amount1 == reserve1 *amount0, "x/y !=dx/dy");
        }
        if (totalSupply ==0) {
            shares = sqrt(amount0* amount1);
        }
        else{
            shares = mint(
                (amount0 * totalSupply) / reserve0,
                (amount1 * totalSupply) / reserve1;
                );
        }
        require(shares > 0, "shares = 0");
        mint(msg.sender , shares);
        reserve0 = token0.balanceOf(address(this));
        reserve1 = token.balanceOf(address(this));

    }

    function removeLiquidity( uint amount0, uint amount1) {
        uint bal0 = token0.balanceOf(address(this));
        uint bal1 = token1.balanceOf(address(this));
       
    }
}