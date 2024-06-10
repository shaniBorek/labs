//SPDX-Licens-identifier: MIT
pragma solidity ^0.8.19;
 
interface ITest{
    function val() external view returns(uint);
    function test() external;
}
contract callback {
    uint public val;

    fallback() external {
        val = ITest(msg.sender).val();
    }

    function test(address addr) external {
        ITest(addr).test();
    }



}

contract TestStorage{
    uint public val;

    function test() public {
        val =123;
        bytes memory b = "";
        msg.sender.call(b);
    }
}