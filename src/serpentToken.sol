// SPDX-License-Identifier: MIT

pragma solidity ^0.8.8;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract serpentToken is ERC20, Ownable {
    bool private _locked;

    //Events
    event TransferLocked(bool indexed status);

    constructor() ERC20("serpentToken", "ST") Ownable(msg.sender){
        _mint(msg.sender, 100 * 10 ** decimals());
        _locked = false;
    }

    function setTransferLocked(bool status) external onlyOwner {
        _locked = status;
        emit TransferLocked(status);
    }

    function locked() public view returns(bool) {
        return _locked;
    } 

    function transfer(address recipient, uint256 amount) public override returns (bool) {
        require(!_locked || msg.sender == owner(), "Transfers are locked");
        return super.transfer(recipient, amount);
    }

    function transferFrom(address sender, address recipient, uint256 amount) public override returns (bool) {
        require(!_locked || msg.sender == owner(), "Transfers are locked");
        return super.transferFrom(sender, recipient, amount);
    }
}
