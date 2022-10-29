pragma solidity 0.8.17;
 
contract SimpleStorage {
   uint data; //Cette variable est intialisé avec une valeure précise
 
   function get() public view returns (uint) {
       return data;
   }
}
