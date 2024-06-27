---
layout: post
title: "USDT Does Not Comply With ERC20 Standard"
date: 2024-06-27 15:12:29 +0800
categories: jekyll update
---

### Problem Introduction

I am running into this erros when i swap USDT to DAI by uniswap. The tool i am using is `foundry`.

```solidity
    ├─ [24953] 0xdAC17F958D2ee523a2206206994597C13D831ec7::approve(SimpleSwap: [0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f], 1000)
    │   ├─ emit Approval(owner: 0x3f5CE5FBFe3E9af3971dD833D26bA9b5C936f0bE, spender: SimpleSwap: [0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f], value: 1000)
    │   └─ ← [Stop]
    └─ ← [Revert] EvmError: Revert
```

Here is my test code in `SimpleSwap.t.sol`

```javascript
IERC20 tokenIn = IERC20(USDT);
uint256 balOfWhale = tokenIn.balanceOf(USDT_WHALE);
tokenIn.approve(address(simpleSwap), 1000);
uint256 amountOut = simpleSwap.swap(USDT, DAI, 1000);
```

After google the result, i know that the USDT does not complement the `approve` function same as `ERC20` standard smart contract.
The approve function in USDT does not have the return value. But the standard interface in ERC20 have a bool return value.

```javascript
   function approve(address _spender, uint _value) public onlyPayloadSize(2 * 32) {
        require(!((_value != 0) && (allowed[msg.sender][_spender] != 0)));
        allowed[msg.sender][_spender] = _value;
        Approval(msg.sender, _spender, _value);
   }
```

Code above from [ethescan USDT smart contract](https://etherscan.io/address/0xdAC17F958D2ee523a2206206994597C13D831ec7#code)

```javascript
    function approve(address spender, uint256 value) public virtual returns (bool) {
        address owner = _msgSender();
        _approve(owner, spender, value);
        return true;
    }
```

### The solution

So the return value indeed is different between USDT and ERC20 standard.
But why the evm fails?
That is because evm will check the return data size when invoking a function of smart contract.
So there are two ways to solove this problem.

1. Don't use standard ERC20 approve interface
   Instead of import IERC20 from OpenZepplin, we write our own IERC20.

```javascript
interface IERC20 {
    function approve(address spender, uint256 value) external;
}
```

I already try it, it really works. The code is in [USDTSwapWithoutStandardERC20.t.sol](https://github.com/heeween/foundryProject/blob/main/uniswap/test/USDTSwapWithoutStandardERC20.t.sol)

But if we write our own IERC20. Then other tokens that apply ERC20 standard will fails. So the second way should be the best practice to solve this problem.

2. Use safeERC20 library

```javascript
import "../lib/openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol";
contract SimpleSwapTest is Test {
    using SafeERC20 for IERC20;

    function testSwapFromUSDTToDAI() public {
      ...
      IERC20 tokenIn = IERC20(USDT);
      tokenIn.forceApprove(address(simpleSwap), 1000);
      ...
    }
}
```

As the documentation of forceApprove in SafeERC20. The extension of ERC20 use `encodeCall` to bypass the return value checking in Ethereum.
The full code is in here [USDTSwapWithSafeERC20.t.sol](https://github.com/heeween/foundryProject/blob/main/uniswap/test/USDTSwapWithSafeERC20.t.sol)
