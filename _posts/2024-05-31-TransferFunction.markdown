---
layout: post
title:  "Difference between address(token).transfer and token.transfer"
date:   2024-05-31 09:11:29 +0800
categories: jekyll update
---

We know that every token implements IERC20 has the transfer function. And every account in ethereum also has the transfer function.

As a ERC20 contract, we can call the transfer function in the smart contract like this `token.transfer(msg.sender,amount)`. As a ERC20 account we call the transfer function like this `address(this).transfer(amount)`. 

But be aware that these two line codes are very different. `token.transfer(msg.sender,amount)` is to transfer the ERC20 token from the contract to the msg.sender.

And `address(token).transfer(amount)` is using to transfer ethereum coins from the contract to the token account. If the 