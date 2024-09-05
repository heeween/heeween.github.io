---
layout: post
title: "failed to resolve file in Openzepplin"
date: 2024-07-01 17:41:29 +0800
categories: jekyll update
---

### Problem Introduction

When i use foundry to test uniswapV3 `addLiquidity` functionality, i encounter this error.

```solidity
➜  uniswap git:(main) ✗ forge build
[⠃] Compiling...2024-07-01T09:43:55.255008Z ERROR foundry_compilers::artifacts: error="/Users/helaoda/Desktop/frontEnd/foundryProject/uniswap/lib/openzeppelin-contracts/token/ERC721/IERC721Metadata.sol": No such file or directory (os error 2)
[⠊] Compiling...
Error:
failed to resolve file: "/Users/helaoda/Desktop/frontEnd/foundryProject/uniswap/lib/openzeppelin-contracts/token/ERC721/IERC721Metadata.sol": No such file or directory (os error 2); check configured remappings
        --> /Users/helaoda/Desktop/frontEnd/foundryProject/uniswap/lib/v3-periphery/contracts/interfaces/INonfungiblePositionManager.sol
        @openzeppelin/contracts/token/ERC721/IERC721Metadata.sol
```

This is because the `INonfungiblePositionManager` contract in UniswapV3 have a dependency to `IERC721Metadata` contranct from `OpenZeppelin/openzeppelin-contracts`. And the version of `Openzeppelin` in UniswapV3 dependency is `"@openzeppelin/contracts": "3.4.2-solc-0.7",`.
But in the lastest version of `@openzeppelin` has change file `IERC721Metadata` from ERC721 folder into a subdirectory Extension folder in ERC721 folder.

### Hot to fix

There are several solutions to fix that.

1.Copy a INonfungiblePositionManager into your own project directory.

2.Use foundry to install a lower version like `3.4.2`.
