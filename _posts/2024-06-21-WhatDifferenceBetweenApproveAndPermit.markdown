---
layout: post
title: "How does signature works"
date: 2024-06-21 15:34:29 +0800
categories: jekyll update
---

### A transaction using Approve in ERC20

1. Owner of the token make a transaction to the ERC20 token contract. The value in this transaction is zero. The main purpose of this transaction is to call the approve function to approve some amount allowence to the spender. The spender usually is a contract, like a bid contract.
   2.The spender make a transaction to the bid contract. to call some function of the bid contract. In the function, use address of the ERC20 token to call `transferFrom` function to transfer some amount ERC20 tokens from the owner to the bid contract. And also consume the allowence of the spender.

### A transaction using Permit in ERC20Permit

Any account call the function in the bid contract. First call the premit function in the ERC20PermitToken to approve allowence to the account.
Then call the `transferFrom` function from the owner to the bid contract. Here the `msg.sender` is the account, so the transaction call be successful.

| Approve          | Permit          |
| ---------------- | --------------- |
| two transactions | one transaction |
| higt gas cost    | low gas cost    |
| have expire time | no limitation for time|
| have usage nonce | no explicit times used|

the only thing in the permit transaction the owner should give is the signature of the permit transaction. It is quite easy for the owner to send a transaction for multiple contracts that compatible with the `ERC20Permit` protocol.
