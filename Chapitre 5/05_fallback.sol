// mauvais
fallback() external payable { balances[msg.sender] += msg.value; }
 
// mieux
function deposit() payable external { balances[msg.sender] += msg.value; }
 
fallback() external payable { emit LogDepositReceived(msg.sender); }