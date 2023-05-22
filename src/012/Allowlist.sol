// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// Write a contract that holds an allowlist, e.g. a list of privileged addresses.
// Initial owner is the contract deployer.
// Implemenent the owner pattern + a list of operators.
// An operator can add/remove address to the isAllowed list.
// The owner can add/remove address to the isAllowed list + can add/remove operators.
contract Allowlist {
    address public owner;
    mapping(address => bool) public operators;
    mapping(address => bool) public isAllowed;

    error OnlyOwner();
    error OnlyOperator();

    constructor() {
        owner = msg.sender;
    }

    modifier isOperator() {
        if(operators[msg.sender] != true) {
            revert OnlyOperator();
        }
        _;
    }

    modifier isOwner() {
        if(msg.sender != owner) {
            revert OnlyOwner();
        }
        _;
    }

    /// @param who The address to add to the operators
    function addOperator(address who) external isOwner {
        operators[who] = true;
    }

    /// @param who The address to remove from the operators
    function removeOperator(address who) external isOwner {
        delete operators[who];
    }

    /// @param who The address to add to the allow list
    function add(address who) external isOperator{
        isAllowed[who] = true;
    }

    /// @param who The address to remove to the allow list
    function remove(address who) external isOperator{
        delete isAllowed[who];
    }
}
