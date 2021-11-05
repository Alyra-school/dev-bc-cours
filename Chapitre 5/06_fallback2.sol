// mauvais
function() payable { emit LogDepositReceived(msg.sender); }

// bon
function() payable { require(msg.data.length == 0); emit LogDepositReceived(msg.sender); }