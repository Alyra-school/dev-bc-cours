// FlashLoans.sol
pragma solidity ^0.6.6;

//le code importer d’AAVE est toujours en version ^0.6.6. Il est donc impossible pour nous de mettre notre contract dans la dernière version de solidity
//Il est aussi incompatible avec ses propres import d'openzeppelin... Il ne compile plus.
 
import "https://github.com/aave/flashloan-box/blob/Remix/contracts/aave/FlashLoanReceiverBase.sol";
import "https://github.com/aave/flashloan-box/blob/Remix/contracts/aave/ILendingPoolAddressesProvider.sol";
import "https://github.com/aave/flashloan-box/blob/Remix/contracts/aave/ILendingPool.sol";
 
 
contract FlashLoans is FlashLoanReceiverBase {
   ILendingPoolAddressesProvider provider;
   address dai;
  
   constructor(
       address _provider,
       address _dai)
       FlashLoanReceiverBase(_provider)
       public {
       provider = ILendingPoolAddressesProvider(_provider);
       dai = _dai;
   }
}
