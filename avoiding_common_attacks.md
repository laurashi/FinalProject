Avoiding Common Attacks

Using Specific Compiler Pragma
Contracts should be deployed with the same compiler version and flags that they have been tested the most with. This contract should use a compiler version later or equals to 0.6 with address payable being used.

<pragma solidity >=0.6.0 <0.9.0;>

Proper Use of Require, Assert and Revert 
With the contract a simple one and we don't want all gas being burned, Require() is practically more suitable.

<require(Houses[_sku].state == State.Rent);>
