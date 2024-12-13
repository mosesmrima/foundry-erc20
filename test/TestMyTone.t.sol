//SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";
import {console} from "forge-std/Script.sol";
import {DeployMyToken} from "../script/DeployMyToken.s.sol";
import {MyToken} from "../src/MyToken.sol";

contract TestMyToken is Test {
    MyToken myToken;
    address immutable USER_1 = makeAddr("user1");

    function setUp() public {
        myToken = new DeployMyToken().run();
    }

    function testTokenIsDeployed() public view {
        assert(address(myToken) != address(0));
    }

    function testOwnerRecievesMintedTokens() public view {
        uint256 ownerBalance = myToken.balanceOf(msg.sender);
        assert(ownerBalance > 0);
    }

    function testTransfer() public {
        uint256 ownerInitialBalance = myToken.balanceOf(msg.sender);
        console.log("initlia owner balance  ", ownerInitialBalance);

        vm.prank(msg.sender);
        myToken.transfer(USER_1, 5);

        uint256 ownerEventualBalance = myToken.balanceOf(msg.sender);
        uint256 userEventualBalance = myToken.balanceOf(USER_1);

        assert(ownerInitialBalance - ownerEventualBalance == 5);
        assert(userEventualBalance == ownerInitialBalance - ownerEventualBalance);
    }
}
