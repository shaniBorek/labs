//SPDX-Licens-Identifier: MIT
pragma solidity ^0.8.19;

contract Error {
    function testRequire(uint i) public pure {
        require(i < 10, "must be biger then 10");
    }

    function testRevert(uint i ) public pure {
        if(i < 10)
        revert("must be biger then 10");

    }

    function testAssert(uint i) public view {
        assert(i == 1);
    }

    error errorMesge(uint index) ;

    function testError(uint _index) public view {
        if(_index < 5)
        {
            revert errorMesge({index: _index});
        }
    }
}

contract account {
    uint public balance;
    uint public max_uint = 2** 256-1;

    function deposit(uint amount) public {
        uint oldBalance = balance;
        uint newBalance = balance + amount;
        require(oldBalance < newBalance ," overflow");
        balance = newBalance;
        assert(balance >= oldBalance);
    }

    function withdraw(uint amount) public {
        uint oldBalance = balance;
        require(amount <= oldBalance, "Underflow");
        balance -= amount;
        assert(balance <= oldBalance);
    }
}