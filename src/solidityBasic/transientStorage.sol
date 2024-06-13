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

contract TestTransientStorage {
    bytes32 constant SLOT = 0;

    // function test() public {
    //     assembly {
    //         tstore(SLOT, 321)
    //     }
    //     bytes memory b = "";
    //     msg.sender.call(b);
    // }

    // function val() public view returns (uint256 v) {
    //     assembly {
    //         v := tload(SLOT)
    //     }
    // }
}

contract ReentrancyGuard {
    bool private locked;
    modifier lock() {
        require(!locked);
        locked = true;
        _;
        locked = false;
    }

    function test() public lock{
        bytes  memory b = "";
        msg.sender.call(b);
    }
}

contract ReentrancyGuardTransient  {
    bytes32 constant SLOT = 0;

    // modifier lock(){
    //     assembly {
    //     if tload(SLOT){revert(0,0)}
    //     tstore(tstore(SLOT, 0))
    // }

    // assembly {
    //     tstore(SLOT, 0)
    // }

    // }
    
    // function test() external lock{
    //      bytes memory b = "";
    //     msg.sender.call(b);
    // }
}