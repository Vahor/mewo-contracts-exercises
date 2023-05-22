// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ERC721} from "openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";

// Write a sale contract that allow users to purchase NFTs.
// Maximum supply should be 10,000.
// Each NFT will be sold at 0.05 ether for the first 1,000 units, them 0. ether for the rest of the supply.
contract MyNFT is ERC721 {
    uint256 public constant EARLY = 0.05 ether;
    uint256 public constant NORMAL = 0.1 ether;
    uint16 public constant EARLY_BATCH = 10_000;

    uint16 public totalSupply = 0;

    error InsufficientValue(uint256 expected, uint256 actual);

    constructor() ERC721("MyNFT", "MNFT") {}

    function max(uint256 a, uint256 b) private view returns (uint256)  {
        if (a > b) return a;
        return b;
    }

    function min(uint256 a, uint256 b) private view returns (uint256)  {
        if (a < b) return a;
        return b;
    }

    function price(uint256 quantity) public view returns (uint256) {
        require(quantity > 0);
        uint256 withEarlyPrice = totalSupply > EARLY_BATCH ? 0 : min(quantity, EARLY_BATCH);
        uint256 withNormalPrice = max(quantity - withEarlyPrice, 0);

        uint256 earlyPrice = withEarlyPrice * EARLY;
        uint256 normalPrice = withNormalPrice * NORMAL;

        return earlyPrice + normalPrice;
    }

    function purchase(uint256 quantity) external payable {
        require(quantity > 0);
        uint256 price = price(quantity);
        if (price > msg.value) {
            revert InsufficientValue(price, msg.value);
        }

        for (uint256 i = 0; i < quantity; ++i) {
            _safeMint(msg.sender, ++totalSupply);
        }
    }
}
