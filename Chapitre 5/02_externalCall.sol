// mauvais
someAddress.send(55);
someAddress.call{value:55}(""); // this is doubly dangerous, as it will forward all remaining gas and doesn't check for result
someAddress.call{value:100}(bytes4(sha3("deposit()"))); // if deposit throws an exception, the raw call() will only return false and transaction will NOT be reverted

// bon
(bool success, ) = someAddress.call{value:55}("");
if(!success) {
    // handle failure code
}