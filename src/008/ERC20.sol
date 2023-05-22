// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {IERC20} from "./IERC20.sol";

// Write an implemetantion of the ERC20 standard
// See the {IERC20} interface
contract ERC20 is IERC20 {
    string constant public name = "Bozo";
    string constant public symbol = "BOZO";
    uint8 constant public decimals = 8;

    uint256 public totalSupply = 800_000;

    address public owner;
    mapping(address => uint256) private balances;
    mapping(address => mapping(address => uint256)) private allowances;

    constructor() {}

    function balanceOf(address _owner) public view returns (uint256 balance) {
        return balances[_owner];
    }

    function transfer(address _to, uint256 _value) public returns (bool success){
        require(balances[msg.sender] >= _value);

        balances[msg.sender] -= _value;
        balances[_to] += _value;

        emit Transfer(msg.sender, _to, _value);

        return true;
    }

    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success){
        require(balances[_from] >= _value);
        require(allowances[_from][_to] >= _value);

        allowances[_from][_to] -= _value;

        balances[_from] -= _value;
        balances[_to] += _value;

        emit Transfer(_from, _to, _value);

        return true;
    }

    function approve(address _spender, uint256 _value) public returns (bool success){
        allowances[msg.sender][_spender] += _value;

        emit Approval(msg.sender, _spender, _value);

        return true;
    }

    function allowance(address _owner, address _spender) public view returns (uint256) {
        return allowances[owner][_spender];
    }
}
