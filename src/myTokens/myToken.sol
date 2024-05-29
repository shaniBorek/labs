// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/ERC20/ERC20.sol";

contract MyToken is ERC20 {
    constructor(string memory name, string memory symbol) ERC20(name, symbol) {}

    function mint(address to, uint256 tokenId) external {
        _mint(to, tokenId);
    }

        function burn(address to, uint256 tokenId) external {
        _burn(to, tokenId);
    }
}