---
layout: post
title:  "Difference between address(this).transfer and token.transfer"
date:   2024-05-31 09:11:29 +0800
categories: jekyll update
---

We know that every token implements IERC20 has the transfer function. And every account in ethereum also has the transfer function.
As a ERC20 contract, we can call the transfer function in the smart contract like this `token.transfer`. As a ERC20 account we call the transfer function like this `address.transfer`. 
But be aware that these two code is very different. `token.transfer` is to transfer the ERC20 token to the receivor