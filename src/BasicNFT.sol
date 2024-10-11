// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
import {ERC721} from "@Openzeppelin/contracts/token/ERC721/ERC721.sol";

// tokenUrl(1) => 1 is the id.

contract BasicNFT is ERC721 {
    uint256 private s_tokenCounter;
    mapping(uint256 => string) private s_tokenIdToUri;

    constructor() ERC721("Doggie", "DOG") {
        s_tokenCounter = 0;
    }

    function mintNFT(string memory tokenUri) public {
        s_tokenIdToUri[s_tokenCounter] = tokenUri;

        _safeMint(msg.sender, s_tokenCounter);

        s_tokenCounter++;
    }

    function tokenURI(
        uint256 tokenId
    ) public view override returns (string memory) {
        return s_tokenIdToUri[tokenId];
    }
}