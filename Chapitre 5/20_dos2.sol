pragma solidity 0.8.9;

contract Refund {
   address[] private refundAddresses;
   mapping (address => uint) public refunds;
   
   // Mauvais
   function refundAll() public {
      for(uint x; x < refundAddresses.length; x++) {               
          require(payable(refundAddresses[x]).send(refunds[refundAddresses[x]]));
      }
   }
}
