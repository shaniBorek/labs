//SPDX-Licenes-Identifier: MIT
pragma solidity ^0.8.19;
contract A{
    event Log(string mesegge);
    function foo() public virtual {
        emit Log("a.foo");
    } 

    function bar() public virtual {
        emit Log("a.bar");
    }
    
}

contract B is A{
    function foo() public virtual override{
        emit Log("b.foo");
        A.foo();
    }

    function bar() public virtual override {
        emit Log("b.bar");
        super.bar();
    }
}

contract C is A {
    function foo() public virtual override{
        emit Log("C.foo");
        A.foo();
    }

    function bar() public virtual override{
        emit Log("C.foo");
        A.bar();
    }
}

contract D is B, C {

    function foo() public virtual override(B , C){
        super.foo();
    }

    function bar() public virtual override(B, C){
        super.bar();
    }
}