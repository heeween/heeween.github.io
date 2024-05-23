---
layout: post
title:  "Two Ways To Create Contracts"
date:   2024-05-23 21:18:29 +0800
categories: jekyll update
---

### Number one, creating contracts by deploy
We know mostly we can transfer from External Owned Account to 0x0 to create a new contract. The code in this transaction will be executed on Ethereum Virtual Machine. And the contract address will be logged in the state tree.

> The contract address is usually given when a contract is deployed to the Ethereum Blockchain. The address comes from the creator's address and the number of transactions sent from that address (the “nonce”).

```solidity
    constructor(uint256 _initialSupply) ERC20("MyToken", "MT") {
        _mint(msg.sender, _initialSupply);
        owner = msg.sender;
    }
```
This code was transferred in transaction from EOA to 0x0. This constructor will only be called one time. After the contract is deployed.

### Number two, creating contracts by invoke functions in one contract
There are also another way to create a new contract. We can use `new` keyword in a contract function to create a new contract. We can just send a transaction to the contract. And invoke the function to create a new contract.

```solidity
    function createAccount(address _owner) external payable  {
        Account account = new Account{value:111}(_owner);
        accounts.push(account);
    }
```

By this way, the account contract will also be logged in the state tree. But this address will not be displayed in the transaction. So We can save the account contract address and access the account contract content directly by address.