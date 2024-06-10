//SPDX-Licens-Identifier: MIT
pragma solidity ^0.8.19;
import "forge-std/Test.sol";


contract contractTest is Test{
    ArrayDeletionBug arrBug;
    FixedArrayDeletion arrFix;

    function setUp() public {
        arrBug = new ArrayDeletionBug();
        arrFix = new FixedArrayDeletion();
    }

    function testArrayDeletion() public {
        arrBug.arr(1);
        arrBug.deleteElement(1);
        arrBug.arr(1);
        arrBug.getLength();
    }

    function testFixedArrayDeleted() public {
        arrFix.arr(1);
        arrFix.deletElement(1);
        arrFix.arr(1);
        arrFix.getLength();
    }
    receive() external payable{}

}
contract ArrayDeletionBug {
    uint[] public arr = [1,2,3,4,5];
    function deleteElement(uint i) public {
        require(i < arr.length ,"this index don't exit");

        delete arr[i];
    }

    function getLength() public returns(uint) {
        return arr.length;
    }
}
contract FixedArrayDeletion {

    uint[] public arr =[1,2,3,4,5,6];
    function deletElement(uint i) public {
    require(i < arr.length, "invaled index");
    arr[i] = arr[arr.length - 1];
    arr.pop;
    }

 function getLength() public returns(uint) {
        return arr.length;
    }
}
