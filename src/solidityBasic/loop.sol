//SPDX-Licens-Identifier: MIT
pragma solidity ^0.8.19;
contract Loop {
    function loop() public {
        for(uint i = 0 ; i < 10; i++){
            if(i < 5 ) {
                continue;
            }
            else 
            if(i < 10) {
                break;
            }
        }

        uint i = 0;
        while(i< 10){
            i++;
        }
    }
}