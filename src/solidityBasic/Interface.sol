//SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract Counter {
    uint public counter;
    function increment() external {
        counter += 1;
    }
}

interface ICount {
    function Count() external view returns(uint);
    function increment() external ;
}

contract MyContract{
    function incrementCounter(address _counter) external {
        ICount(_counter).increment();
    }

    function GetCount(address _counter) external view returns(uint){
        return ICount(_counter).Count();
    }
}

interface UniswapV2Factair{
    function getPair(address tokenA, address tokenB) external view returns(address pair);

}

interface UniswapV2Pair{
    function getReserves() external view returns(uint reserve0 , uint reserve1, uint blookTimeStamp);
}

contract UniswapExample{
     address private factory = 0x5C69bEe701ef814a2B6a3EDD4B1652CB9cc5aA6f;
    address private dai = 0x6B175474E89094C44Da98b954EedeAC495271d0F;
    address private weth = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;

    function getTokenReserves() external view returns (uint256, uint256) {
        address pair = UniswapV2Factory(factory).getPair(dai, weth);
        (uint256 reserve0, uint256 reserve1,) =
            UniswapV2Pair(pair).getReserves();
        return (reserve0, reserve1);
    }
}