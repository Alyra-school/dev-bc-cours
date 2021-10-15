pragma solidity >=0.8.0 <0.9.0;
 
contract SimpleStorage {
   uint data; //Cette variable est intialisé avec une valeure précise
 
   function get() public view returns (uint) {
       return data;
   }
}
