// mauvais
fallback() external payable { emit LogDepositReceived(msg.sender); }
 
// mieux
fallback() external payable { require(msg.data.length == 0); emit LogDepositReceived(msg.sender); }