// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";
import "@hack/auction/auction.sol";
import "@openzeppelin/ERC721/IERC721.sol";
import "@hack/myTokens/nft1.sol";
contract AuctionTest is Test {
    Auction auction;
    MyERC721 token;


    function setUp() public {
        token = new MyERC721("MyNFT", "NFT");
        auction = new Auction(address(token));
        token.mint(address(this),1);
        token.mint(address(this),2);
    }

    function test_startAuction_success() public{
        vm.warp(1648739200);
        console.log(msg.sender);
        console.log(address(auction));
        console.log(msg.sender);
        token.approve(address(auction), 1);
        auction.startAuction(1, 5 days, 20);
        console.log("seller:", auction.getAuction(1).seller);
    }

    function test_startAuction_unsuccess() public{
        vm.warp(1648739200);
        // address user = address(1234);
        // vm.startPrank(user);
        token.approve(address(auction), 1);
        vm.expectRevert();
        auction.startAuction(1, 0 days, 20);
        auction.startAuction(1, 5 days, 20);
        vm.expectRevert();
        auction.startAuction(1, 4 days, 20);
        vm.expectRevert();
        auction.startAuction(2, 4 days, 0);
       
    }
 
    function test_placeBid() public {
        vm.warp(1648739200);
        token.approve(address(auction), 1);
        auction.startAuction(1, 5 days , 20);
        address bidder = address(1234);
        vm.startPrank(address(1234));
        vm.deal(bidder, 1000);
        console.log("address bidder" , msg.sender);
        console.log("bidder balance before:", bidder.balance);
        uint ablanceBefor = bidder.balance;
        uint contractAmount = address(auction).balance;
        vm.warp(1648739200 + 1 days);
        uint amount = 500;
        auction.placesBid{ value: amount }(1);
        console.log("bidder balance after:", bidder.balance);
        assertEq(ablanceBefor - amount , bidder.balance, "The balance is not equal");
        assertEq(contractAmount + amount , address(auction).balance);
        vm.warp(1648739200 + 7 days);
    }

    function test_placeBider_unsuccess()public {
       vm.warp(1648739200);
        address bidder = address(1234);
        vm.startPrank(bidder);
        vm.deal(bidder, 1000);
        vm.expectRevert();
        auction.placesBid{value: 200}(1);
        vm.stopPrank(); 
        token.approve(address(auction), 1);
        auction.startAuction(1, 5 days , 20);

        token.approve(address(auction), 2);
        auction.startAuction(2, 5 days , 20);

        vm.startPrank(bidder);
        vm.warp(1648739200 + 6 days);
        vm.expectRevert();
        auction.placesBid{value: 200}(1);

        vm.warp(1648739200 );
        vm.expectRevert();
        auction.placesBid{value: 0}(1);

         vm.expectRevert();
        auction.placesBid{value: 2000}(1);

         vm.expectRevert();
        auction.placesBid{value: 10}(1);


    }

    function test_endAuction() public{
        vm.warp(1648739200);
        address bidder = address(1234);
        vm.deal(bidder, 1000000000000000);
        token.approve(address(auction), 1);
        auction.startAuction(1, 5 days , 20);
        vm.startPrank(bidder);
        auction.placesBid{value: 500}(1);
        vm.warp(1648739200 + 6 days);
        uint sellerBalance = auction.getAuction(1).seller.balance;
        uint bidderBalance = token.balanceOf(bidder);
        uint contractBalance = address(auction).balance;
        console.log("balance this", address(this).balance);
        console.log("seller balance befor" , auction.getAuction(1).seller.balance);
        console.log("contract balance befor", address(auction).balance);
        console.log("bidder balance nft befor",token.balanceOf(bidder) );
        
        
        auction.endAuction(1);
       

        console.log("seller balance after" , auction.getAuction(1).seller.balance);
        console.log("contract balance after", address(auction).balance);
        console.log("bidder balance nft after",token.balanceOf(bidder) );
        //assertEq(sellerBalance + 500, auction.getAuction(1).seller.balance);
        

    }
}

