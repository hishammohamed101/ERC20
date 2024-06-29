//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "../src/serpentToken.sol";

contract DeploySerpentToken is Script {
    function run() external returns (serpentToken) {
        serpentToken token = new serpentToken();
        return token;
    }
}