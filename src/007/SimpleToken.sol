// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// It's time to start to create tokens!
// Create a contract that represents a token.
// Its constructor will include an address parameter that will be the `owner` of the contract.
// - owner() that returns who is the `owner` of the contract.
// - transferOwnership(address to) that changes who is the owner.
// - balanceOf(address who) that returns the balance of the address `who`.
// - transfer(address to, uint256 amount) that allow to transfer `amount` tokens to the address `to`. The sender must have enough tokens!
// - mint(address to, uint256 amount) that allow to mint `amount` tokens to the address `to`. Only owner cam mint tokens.
contract SimpleToken {

    address public owner;
    mapping(address => uint256) private tokens;

    constructor(address _owner) {
        owner = _owner;
    }

    modifier isOwner() {
        require(msg.sender == owner);
        _;
    }

    function transferOwnership(address to) public isOwner {
        owner = to;
    }

    function balanceOf(address who) public view returns (uint256) {
        return tokens[who];
    }

    function transfer(address to, uint256 amount) public {
        require(tokens[msg.sender] >= amount);
        tokens[msg.sender] -= amount;
        tokens[to] += amount;
    }

    function mint(address to, uint256 amount) public isOwner
    {
        tokens[to] += amount;
    }
}
