//SPDX-Licens-Identifier: MIT
pragma solidity ^0.8.19;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "foundry-huff/HuffDeployer.sol";

contract ContractTest is Test{
    LotteryGame l ;
    function setUp() public{
         l = new LotteryGame();
    }
    function testGame() public {
        address alice =  address(1);
        address bob  = address(2);
       

         console.log(
            "Alice performs pickWinner, of course she will not be a winner"
        );

        vm.startPrank(alice);
        l.pickWinner(alice);
        console.log("Prize: ", l.prize());

        console.log("Now, admin sets the winner to drain out the prize.");
        l.pickWinner(bob);
        console.log("Admin manipulated winner: ", l.winner());
        console.log("Exploit completed");
    }
    receive() external payable{}
}

contract LotteryGame {
    uint public prize = 1000;
    address public winner;
    address public admin = msg.sender;

    modifier safeChack()  {
        if(msg.sender == referee()){
             _;
        }
        else {
            getkWinner();
        }
    }
   

    function referee() internal view returns (address user){
        assembly {
            user := sload(2)
        }
    }

    function pickWinner(address random) public safeChack {
        assembly {
            sstore(1, random)
        }
    }

    function getkWinner()public view returns(address) {
        console.log("Current winner", winner);
        return winner;
    }
}