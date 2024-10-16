// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
import {Script} from "forge-std/Script.sol";
import {MoodNft} from "src/MoodNFT.sol";

contract DeployMoodNft is Script {
    function run() external returns (MoodNft) {
        vm.startBroadcast();
        MoodNft moodNft = new MoodNft();
        vm.stopBroadcast();
        return moodNft;
    }
}
