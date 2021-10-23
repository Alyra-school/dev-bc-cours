pragma solidity 0.8.9;

contract Time {
	function getTime() public view returns(uint){
		return block.timestamp;
	}
}
