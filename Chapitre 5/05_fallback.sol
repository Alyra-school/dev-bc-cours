// mauvais
function() payable { balances[msg.sender] += msg.value; }

// bon
function deposit() payable external { balances[msg.sender] += msg.value; }

function() payable { require(msg.data.length == 0); emit LogDepositReceived(msg.sender); }
