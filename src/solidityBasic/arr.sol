//SPDX-Licens-Identifier: MIT
pragma solidity ^0.8.19;

contract Array {
    uint[] public arr;
    uint[] public arr2 = [1,2,3];
    uint[10] public myFixedSizeArr;

    function get(uint i)  public view returns(uint){
        return arr[i];
    }

    function getArr() public view returns (uint[] memory) {
        return arr;
    }  

    function push(uint i) public {
        arr.push(i);
    }

    function pop()public {
        arr.pop();
    }

    // function getLength() public view returns(uint ) {
    //    return arr.length();
    // }

    function remove(uint i) public {
        delete arr[i];
    }

    function examples() external {
        uint[] memory a = new uint[](5);
    }
}

contract ArrayRemoveByShifting {

    uint[] public arr;

    function remove(uint i) public {
        require(i < arr.length , "index out of bounda");
        for(uint j = i ; j < arr.length - 1; j++){
            arr[j] = arr[j+1];
        }
        arr.pop();
    }

    function test() external {
        arr = [1,2,3,4,5,6];
        remove(2);
        assert(arr[0] == 1);
        assert(arr[1] == 2);
        assert(arr[2] == 4);
        assert(arr.length == 5);
            }
}

contract ArrayReplaceFromEnd {
    uint[] public arr ;
    function remove(uint index) public {
        arr[index] = arr.length-1;
        arr.pop();
    }

    function test() public {
        arr = [1,2 ,3,4 ,5];
        remove(1);
        assert(arr[0] == 1);
        assert(arr[1] == 5);
        assert(arr.length == 4);
    }
}
