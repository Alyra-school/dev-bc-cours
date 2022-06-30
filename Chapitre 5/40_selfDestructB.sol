// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.12;

contract Wallet{

	// Activation of selfdestruct at addr address
  function activateSelfdestruct(address addr) public {
      selfdestruct(payable(addr));
  }
}
