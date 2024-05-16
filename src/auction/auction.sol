// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import "@openzeppelin/ERC721/IERC721.sol";
import "forge-std/console.sol";



contract Auction {

  struct auctionSeller {
        address seller;
        uint tokenId;
        bool started;
        uint endTime; 
        address highestBidder;
        uint highestBid;
    }
    
    address  owner;
    mapping(address => uint)public bidders;
    bool public started;
    uint public endTime;
    IERC721 NFT;
    error err(string message);
    mapping(uint => auctionSeller)  public auctions;
    
     


    constructor(address NFTaddress) {
        NFT = IERC721(NFTaddress);    
    }

    event Start(uint startTime, uint endTime, uint NFT);
    event Bid(address sender, uint amount);
    event Withdraw(address bid);
    event End(address winner, uint amount);

    receive() external payable {}
    function getAuction(uint auctionId) public view returns (auctionSeller memory) {
        return auctions[auctionId];
    }

    // modifier onlyOwner() {
    //     require(msg.sender == owner, "not authorized");
    //     _;
    // }
    function startAuction(uint _nftId, uint numDays, uint startAmount) external  {
        // require(msg.sender == auctions[_nftId].seller, "only seller can change");
        require(numDays > 0, "Num days must be bigger than zero");
        require(auctions[_nftId].seller == address(0), "Auction already exist");        
        require(startAmount > 0, "start amount must be bigger than zero");
        auctions[_nftId].seller = msg.sender;
        auctions[_nftId].started = true;
        auctions[_nftId].endTime = block.timestamp + numDays;  
        auctions[_nftId].highestBid = startAmount;
        NFT.transferFrom(msg.sender, address(this), _nftId);
        emit Start(block.timestamp, auctions[_nftId].endTime, _nftId);
    }
    
    function placesBid(uint _nftId) external payable{
        if(auctions[_nftId].seller == address(0)) { 
            revert err("Auction isn't exist");
        }
       if(block.timestamp > auctions[_nftId].endTime) {
            endAuction(_nftId);
        }
        if(auctions[_nftId].started == false){
            revert err("This auction didn't start yet");
        }
        if(msg.value <= 0) {
            revert err("You enter non-valid amount");
        }
        if(address(msg.sender).balance < msg.value) {
            revert err("You don't have enough funds");
        }

        if(msg.value <= auctions[_nftId].highestBid) {
            revert err("The previous bid was higher");
        }

        if(address(0) != auctions[_nftId].highestBidder){
        payable(address(auctions[_nftId].highestBidder)).transfer(auctions[_nftId].highestBid );
        }
        auctions[_nftId].highestBid = msg.value;
        auctions[_nftId].highestBidder = msg.sender; 
        console.log("yyyyyyyyyyyyyyyyyyyyyy",msg.sender);
        emit Bid(msg.sender,  auctions[_nftId].highestBid);
        
    }


    function endAuction(uint _nftId) public {
        require( auctions[_nftId].seller != address(0), "Auction isn't exist");
        require( auctions[_nftId].started == true, "The auction didn't start yet");
        require( auctions[_nftId].endTime <= block.timestamp, "The auction didn't ended yet");
        
        if( auctions[_nftId].highestBidder == address(0)) {
            NFT.transferFrom(address(this), auctions[_nftId].seller, _nftId);
        console.log("wwwwwwwwwwwwwwwww",auctions[_nftId].highestBidder);
        }
        
        else {
            NFT.transferFrom(address(this), auctions[_nftId].highestBidder, _nftId);
            // for(uint i = 0; i < auctions[_nftId].biddersArr.length; i++){
            //     if(auctions[_nftId].bidders[auctions[_nftId].biddersArr[i]] != 0 && 
            //     auctions[_nftId].bidders[auctions[_nftId].biddersArr[i]] != auctions[_nftId].highestBid)
            //     payable(address(auctions[_nftId].biddersArr[i])).transfer(auctions[_nftId].bidders[auctions[_nftId].biddersArr[i]]);
               
            //     }
            console.log("ssssssssssssssss",NFT.balanceOf(auctions[_nftId].highestBidder));
            console.log("seller balance before",address(auctions[_nftId].seller).balance);
            console.log("amount",auctions[_nftId].highestBid);
            console.log("contract balance" ,address(this).balance);
            
            console.log("bidder balance before",address(auctions[_nftId].highestBidder).balance );
            payable(auctions[_nftId].seller).transfer(auctions[_nftId].highestBid);
            console.log("bidder balance after",address(auctions[_nftId].highestBidder).balance ); 
             console.log("seller balance after",address(auctions[_nftId].seller).balance);
        }
        delete auctions[_nftId];
      
    }



    


}


