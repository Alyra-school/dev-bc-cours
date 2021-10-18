pragma solidity 0.8.9;
 
contract Whitelist {
   mapping(address=> bool) whitelist;
   event Authorized(address _address); // Event
}
