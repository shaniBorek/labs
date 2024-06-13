//SPDX-Licens-Identifier: MIT
pragma solidity ^0.8.19;
import "forge-std/Test.sol";

contract contractTest is Test {
    Target target;
    Attack attack;
    FaileAttact faile;
    TargetRemediated targetRem;

    constructor(){
        target = new Target();
        faile = new FaileAttact();
        targetRem = new TargetRemediated();

    }

    function testFAil() public {
        console.log(
            "before expliting",
            target.pwned()
        );

        console.log("after");
        faile.pow(address(target));
    }

    function testByPassContract() public {
        console.log(
            "before ",
            target.pwned()
        );

        attack = new Attack(address(target));
        console.log("after", 
        target.pwned());
        console.log("complit");
    }

    receive() external payable{}
}

contract Target {
    function IsContract(address account) public view returns(bool) {
        // uint size;
        // assembly {
        //     size: = ectcodesize(account)
        // }
        // return size > 0;
    }
    bool public pwned = false;
    function protected()external {
        require(!IsContract(msg.sender), "nocontract allowedddddd");
        pwned  = true;
    }
}


contract Attack {
    bool public isContract;
    address public addr;

    constructor (address _target) {
        isContract = Target(_target).IsContract(_target);
        addr = address(this);
        Target(_target).protected();
    }
}

contract FaileAttact is Test{
    function pow(address addr) external {
        vm.expectRevert();
        Target(addr).protected();
    }
}

contract TargetRemediated {
    function isContract(address account) public view returns(bool){
     require(tx.origin ==msg.sender) ;
     return account.code.length> 0;
}
bool public pwned = false;
function protected() external {
    require(!isContract(msg.sender), "no contract allowed");
    pwned = true;
}
}

