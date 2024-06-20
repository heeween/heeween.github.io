---
layout: post
title:  "Transfer From And Transfer"
date:   2024-05-27 21:52:29 +0800
categories: jekyll update
---

In ERC20 token sepcification, we know that there are two ways to transfer token from one account to another. That are `transfer` and `transfer from` methods. And we know that the `transfer` method just transfers token from the `msg.sender` to another. And `transfer from` methods is transfer from the owner of the token to another account. And there is a pre-condition before `transfer from` frunction be called. That is the owner of the token should approve the `msg.sender` the apporopriate amount tokens. 
I come across an user case when i exercises writing CrownFund smart contract. 
```solidity
    function pledge(uint256 _id, uint256 _amount) external {
        Campaign storage campaign = campaigns[_id];
        require(block.timestamp > campaign.startAt, "campaign not started");
        require(block.timestamp <= campaign.endAt, "campaign ended");
        campaign.pledged += _amount;
        pledgeAmount[_id][msg.sender] += _amount;
        token.transferFrom(msg.sender, address(this), _amount);
        emit Pledge(_id, msg.sender, _amount);
    }
```
When people are pledging a campaign. They should transfer some amount of tokens to the contract. In this line code `token.transferFrom(msg.sender, address(this), _amount);`, They call the function `pledge` in `CrownFund` contract. Then the `CrownFund` contract call the `transferFrom` function through directly call contract. In the `transferFrom` function the msg.sender should be the address of the CrownFund contract. And the receivor for the token is also the CrownFund. So the pledgor have to approve the contract. And then the contract can call the `transferFrom` function to transfer to itself.

And in many cases like one Externally Owned Account want to transfer token to a contract. At first the EOA call one function in the contract. And the contract call token contract to execute the token transaction. So we should use the `transferFrom` function to approve the contract allowance. Then the contract use the algorithm to transfer itself the token. 

The whole code is in my github repository [CrownFund.sol](https://github.com/heeween/RemixProject/blob/main/CrowdFund.sol).