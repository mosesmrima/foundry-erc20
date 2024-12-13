//SPD-License-identifier: MIT

pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {MyToken} from "../src/MyToken.sol";

contract DeployMyToken is Script {
    function run() public returns (MyToken) {
        vm.startBroadcast();
        MyToken myToken = new MyToken(1000 ether);
        vm.stopBroadcast();
        return myToken;
    }
}
