pragma solidity 0.8.9;
 
contract HelloWorld {
   string myString = "Hello World !";
  
   function hello() public view returns (string memory) {
       return myString;
   }
}
