// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {DeployBasicNFT} from "script/DeployBasicNFT.s.sol";
import {BasicNFT} from "src/BasicNFT.sol";

contract BasicNftTest is Test {
    BasicNFT public basicNFT;
    address public USER = makeAddr("USER");
    string public constant PUG =
        "https://ipfs.io/ipfs/QmdGomRfAN2KxPrR58nxoTCK5YoAHnz85iFffHCc7UeTKA?filename=attributes.json";

    function setUp() public {
        DeployBasicNFT deployer = new DeployBasicNFT();
        basicNFT = deployer.run();
    }

    // Test: Test NFT name is correct
    function testNftNameIsCorrect() public {
        string memory name = basicNFT.name();
        // assert(name == "Doggie"); // Wont work

        // assertEq(name, "Doggie"); // Will work
        assert(
            keccak256(abi.encodePacked(name)) ==
                keccak256(abi.encodePacked("Doggie"))
        );
    }

    function testCanMintAndHaveABalance() public {
        vm.prank(USER);
        basicNFT.mintNFT(PUG);

        assert(basicNFT.balanceOf(USER) == 1);
        assert(
            keccak256(abi.encodePacked(basicNFT.tokenURI(0))) ==
                keccak256(abi.encodePacked(PUG))
        );
    }
}
