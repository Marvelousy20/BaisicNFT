// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
import {ERC721} from "@Openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Base64} from "@Openzeppelin/contracts/utils/Base64.sol";

contract MoodNft is ERC721 {
    error MoodNft__NotOwner();

    enum Mood {
        HAPPY,
        SAD
    }

    uint256 private s_tokenCounter;
    string private s_sadSvgImageUri;
    string private s_happySvgImageUri;
    mapping(uint256 => string) private s_tokenIdToUri;
    mapping(uint256 => Mood) private s_tokenIdToMood;

    constructor(
        string memory sadSvgImageUri,
        string memory happySvgImageUri
    ) ERC721("Moon NFT", "MN") {
        s_tokenCounter = 0;
        s_sadSvgImageUri = sadSvgImageUri;
        s_happySvgImageUri = happySvgImageUri;
    }

    function _baseURI() internal pure override returns (string memory) {
        return "data:application/json;base64,";
    }

    function mintNft() public {
        s_tokenIdToMood[s_tokenCounter] = Mood.HAPPY;
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenCounter++;
    }

    function flipMood(uint256 tokenId) public {
        // Ensures only owner of nft can flip token/nft.
        if (!_isApprovedOrOwner == msg.sender) {
            revert MoodNft__NotOwner();
        }

        if (s_tokenIdToMood[tokenId] == Mood.HAPPY) {
            s_tokenIdToMood[tokenId] == Mood.SAD;
        } else {
            s_tokenIdToMood[tokenId] == Mood.HAPPY;
        }
    }

    function tokenURI(
        uint256 tokenId
    ) public view override returns (string memory) {
        string memory imageUri;

        if (s_tokenIdToMood[s_tokenCounter] == Mood.HAPPY) {
            imageUri = s_happySvgImageUri;
        } else {
            imageUri = s_sadSvgImageUri;
        }

        // we need a link string, hence why we use abi.encode() instead of string.concat.
        // The Base64.encode(data) takes bytes data as argument, hence reason for converting to bytes;
        // The first abi.encodePacked() is to concatinate the baseUri and the base64 string;

        return
            string(
                abi.encodePacked(
                    _baseURI(),
                    Base64.encode(
                        bytes(
                            abi.encodePacked(
                                '{"name": "',
                                name(),
                                '", "description": "An NFT that reflects the owners mood.", "attributes": [{"trait_type": "moodiness", "value": 100}], "image": "',
                                imageUri,
                                '"}'
                            )
                        )
                    )
                )
            );
    }

    // Getter functions
    function getNFTMood(uint256 tokenId) public view returns (Mood) {
        return s_tokenIdToMood[tokenId];
    }
}
