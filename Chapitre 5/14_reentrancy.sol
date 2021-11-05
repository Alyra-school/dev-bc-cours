pragma solidity 0.8.9;

contract Bob {
  bool sent = false;
  function ping(address c) public {
      if(!sent){
          c.call{value: 2}("");
          sent = true;
      }
  }
}
contract Mallory{
  fallback () external {
      Bob(msg.sender).ping(address(this));
  }
}
