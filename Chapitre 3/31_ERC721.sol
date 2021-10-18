// contracts/GameItem.sol
// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;
 
import "https://github.com/OpenZeppelin/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/contracts/utils/Counters.sol";
 
contract GameItem is ERC721URIStorage {
   using Counters for Counters.Counter;
   Counters.Counter private _tokenIds;
 
   constructor() ERC721("GameItem", "ITM") {}
 
   function addItem(address player, string memory tokenURI)
       public
       returns (uint256)
   {
       _tokenIds.increment();
 
       uint256 newItemId = _tokenIds.current();
       _mint(player, newItemId);
       _setTokenURI(newItemId, tokenURI);
 
       return newItemId;
   }
}
