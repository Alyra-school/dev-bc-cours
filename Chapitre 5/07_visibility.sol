// mauvais
uint x; // the default is internal for state variables, but it should be made explicit
function buy() { // the default is public
    // public code
}

// bon
uint private y;
function buy() external {
    // only callable externally or using this.buy()
}

function utility() public {
    // callable externally, as well as internally: changing this code requires thinking about both cases.
}

function internalAction() internal {
    // internal code
}