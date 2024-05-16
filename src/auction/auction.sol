// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;
import "@openzeppelin/ERC721/IERC721.sol";


contract Auction {

//   struct auctionSeller {
//         bool  started;
//         uint  endTime; 
//         mapping(address => uint) bidders;
//         address  highestBidder;
//         uint  highestBid;
//     }
    
    address  owner;
    mapping(address => uint)public bidders;
    mapping(address => auctionSeller)public auctionSellerMapping;
    bool public started;
    uint public endTime;
    address public highestBidder;
    uint public highestBid;
    ERC721 NFT;
    error err(string message);

    constructor(uint _endTime , string name, string symble) payable {
        owner = msg.sender;
        started = true;
        endTime = _endTime;
        NFT = new ERC271(name , symble);
        emit Start(block.timestamp, endTime, msg.value);
    }

    // function initial(bool start, uint end) public {
    //   auctionSellerMapping[msg.sender].started = start;
    //   auctionSellerMapping[msg.sender].endTime = end ;
    // }

    event Start(uint startTime, uint endTime, uint NFT);

    event Bid(address sender, uint amount);

      receive() external payable {}
    
    function placesBid() public payable{
        if(block.timestamp > endTime) {
            revert err("This bussiness-requirements ended");
        }
        if(started == false){
            revert err("This bussiness-requirements didn't start yet");
        }
        
        if(msg.value <= 0) {
            revert err("You enter non-valid amount");
        }
        if(address(msg.sender).balance < msg.value) {
            revert err("You don't have enough funds");
        }

        if(msg.value <= highestBid) {
            revert err("The previous bid was higher");
        }

        if(bidders[msg.sender] == 0) {
            bidders[msg.sender] = msg.value;
        }

        else {
            uint amount = msg.value - bidders[msg.sender];
            bidders[msg.sender] += amount;
            payable(address(msg.sender)).transfer(amount);
        }


        highestBid = bidders[msg.sender];
        highestBidder = msg.sender; 

        emit Bid(msg.sender, bidders[msg.sender]);
    }

    function withdraw() public {
        if(bidders[msg.sender] == 0) {
            revert err("You don't exist");
        }
        if(msg.sender.balance == highestBid) {
            revert err("You can't withdraw, yoe are the highest bidder");
        }

        payable(address(this)).transfer(bidders[msg.sender]);
        delete bidders[msg.sender];

    }



    


}