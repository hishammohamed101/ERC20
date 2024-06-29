
# ERC20 Token Project
This repository contains the smart contract code and deployment instructions for an ERC20 token built using Solidity and deployed on a testnet using Forge.

## Overview

This project implements a basic ERC20 token (serpentToken) using Solidity. It includes functionalities such as token transfers, allowance management, and owner-specific operations. The token is deployed on a testnet (Sepolia, for example) using Forge CLI.


## Functions:

```transfer```: Transfer tokens from sender to recipient.
```transferFrom```: Transfer tokens on behalf of a spender (after approval).
```approve```: Approve spender to spend tokens on behalf of the owner.
```setTransferLocked```: Toggle transfer lock status (onlyOwner).


## Deployment
Prerequisites
Ensure you have the following set up:

Forge CLI installed and configured.
Ethereum RPC URL for the desired testnet (e.g., Rinkeby).
Private key of the Ethereum account for deployment.