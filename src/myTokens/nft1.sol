// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/ERC721/ERC721.sol";

contract MyERC721 is ERC721 {
    constructor(string memory name, string memory symbol) ERC721(name, symbol) {}

    function mint(address to, uint256 tokenId) external {
        _mint(to, tokenId);
    }
}