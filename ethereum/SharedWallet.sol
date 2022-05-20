// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

contract SharedWallet {
    address public admin;
    mapping (address => bool) ownerToIsOwner;

    constructor() {
        address deployer = msg.sender;
        admin = deployer;
        ownerToIsOwner[deployer] = true;
    }

    modifier onlyOwner() {
        require(ownerToIsOwner[msg.sender]);
        _;
    }

    function addOwner(address newOwner) onlyOwner public {
        ownerToIsOwner[newOwner] = true;
    }

    function removeOwner(address oldOwner) onlyOwner public {
        ownerToIsOwner[oldOwner] = false;
    }

    function addFunds() onlyOwner public payable {}

    function withdrawFunds(uint amount) onlyOwner public {
        payable(msg.sender).transfer(amount);
    }

}
