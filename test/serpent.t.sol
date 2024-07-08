// // SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/serpentToken.sol";

contract serpentTokenTest is Test {
    serpentToken token;
    address owner = address(0x1);
    address spender = address(0x2);
    address recipient = address(0x3);
    address nonOwner = address(0x4);

    function setUp() public {
        token = new serpentToken();

        // Transfer tokens to the owner address for testing
        token.transfer(owner, 100 * 10 ** token.decimals());
    }

    function testInitialBalanceWithDeployer() public {
        uint256 expectedBalance = 100 * 10 ** token.decimals();
        uint256 actualBalance = token.balanceOf(owner);
        assertEq(actualBalance, expectedBalance, "Initial balance should be 100 tokens");
    }

    function testTransfer() public {
        uint256 amount = 10 * 10 ** token.decimals();

        vm.prank(owner); // Ensure msg.sender is the owner
        token.transfer(recipient, amount);

        uint256 recipientBalance = token.balanceOf(recipient);
        assertEq(recipientBalance, amount, "Recipient should receive transferred amount");
    }

    function testTransferFrom() public {
        uint256 allowance = 100 * 10 ** token.decimals(); // Ensure allowance covers the transfer amount
        uint256 amount = 10 * 10 ** token.decimals();

        // Approve `spender` to spend `allowance` tokens on behalf of `owner`
        vm.prank(owner);
        token.approve(spender, allowance);

        // Check the allowance before calling transferFrom
        uint256 initialAllowance = token.allowance(owner, spender);
        assertEq(initialAllowance, allowance, "Initial allowance should be set correctly");

        // Transfer tokens from `owner` to `recipient` by `spender`
        vm.prank(spender);
        token.transferFrom(owner, recipient, amount);

        // Check the recipient balance after transfer
        uint256 recipientBalance = token.balanceOf(recipient);
        assertEq(recipientBalance, amount, "Recipient should receive transferred amount");

        // Check the final allowance after transfer
        uint256 finalAllowance = token.allowance(owner, spender);
        assertEq(finalAllowance, allowance - amount, "Final allowance should be reduced by the transfer amount");
    }

    function testSetTransferLocked() public {
        // Check initial state
        bool initialLocked = token.locked();
        assertEq(initialLocked, false, "Initial locked state should be false");

        // Set lock status to true
        token.setTransferLocked(true);
        bool lockedAfterSetTrue = token.locked();
        assertEq(lockedAfterSetTrue, true, "Locked state should be true after setting to true");
        console.log("i think this is will fail");

        // Set lock status to false
        token.setTransferLocked(false);
        bool lockedAfterSetFalse = token.locked();
        assertEq(lockedAfterSetFalse, false, "Locked state should be false after setting to false");
    }
}
