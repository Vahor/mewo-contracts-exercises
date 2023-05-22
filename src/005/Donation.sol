// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// Write a contract that allow users to donate ether.abi
// - Only the account that deployed the contract is allowed to withdraw the funds via a `withdraw` function.
// - User will be able to donate ether to the contract via `donate`. Zero donation should be rjected.
// - Expose a `donated(address who)` function that allow to check how much an address has donated.
contract Donation {

    address payable internal owner;
    mapping(address => uint256) private history;

    constructor() {
        owner = payable(msg.sender);
    }

    modifier isOwner() {
        require(msg.sender == owner);
        _;
    }

    function donate() public payable  {
        require(msg.value > 0);
        history[msg.sender] += msg.value;
    }

    function withdraw() public isOwner {
        owner.transfer(address(this).balance);
    }

    function donated(address who) public view returns (uint256) {
        return history[who];
    }

}
