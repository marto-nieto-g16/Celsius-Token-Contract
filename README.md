# CelsiusToken Contract

This is a smart contract written in Solidity that implements the CelsiusToken, an ERC20 token.

## Table of Contents
- [Overview](#overview)
- [Contract Details](#contract-details)
- [Functions](#functions)
- [Deployment](#deployment)
- [Owner](#owner)
- [Transfers](#transfers)

## Overview

The CelsiusToken contract is an implementation of the ERC20 token standard. It provides basic token functionality, including transfers, balance tracking, and approval of token transfers.

## Contract Details

- Solidity Version: 0.4.24
- Compiler Settings: pragma solidity ^0.4.24
- Dependencies: Ownable.sol, ERC20Token.sol

## Functions

The CelsiusToken contract implements the following functions:

- `totalSupply()`: Returns the total supply of tokens.
- `balanceOf(address _owner)`: Returns the token balance of a specific address.
- `transfer(address _to, uint256 _value)`: Transfers tokens from the sender's address to the specified address.
- `transferFrom(address _from, address _to, uint256 _value)`: Transfers tokens from a specified address to another address, if the sender is approved to do so.
- `approve(address _spender, uint256 _value)`: Approves the specified address to spend a certain amount of tokens on behalf of the sender.
- `allowance(address _owner, address _spender)`: Returns the remaining number of tokens that an approved address can spend on behalf of the token owner.
- `freezeTransfers()`: Freezes token transfers. Only the contract owner can call this function.
- `unfreezeTransfers()`: Unfreezes token transfers. Only the contract owner can call this function.

## Deployment

The CelsiusToken contract can be deployed by providing the following constructor arguments:

- `string _name`: The name of the token.
- `string _symbol`: The symbol of the token.
- `uint8 _decimals`: The number of decimal places for the token.
- `uint256 _initialSupply`: The initial supply of tokens.

## Owner

The CelsiusToken contract includes the Ownable contract, which provides ownership functionality. The contract owner has the ability to transfer ownership to another address by calling the `transferOwnership(address newOwner)` function.

## Transfers

The CelsiusToken contract includes the ability to freeze and unfreeze token transfers. When transfers are frozen, all transfer functions will revert. The contract owner can freeze transfers by calling the `freezeTransfers()` function and unfreeze transfers by calling the `unfreezeTransfers()` function.

