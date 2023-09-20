// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;

import "forge-std/Test.sol";
import "../src/AlyraIsERC20.sol";

contract SimpleStorageTest is Test {
    string _name = "Alyra";
    string _symbol = "ALY";
    uint256 _initialSupply = 10000 * 10 ** 18;
    address _owner = makeAddr("User0");
    address _recipient = makeAddr("User1");
    uint256 _decimal = 18;

    AlyraIsERC20 _alyraIsERC20;

    function setUp() public {
        vm.prank(_owner);
        _alyraIsERC20 = new AlyraIsERC20(_initialSupply);
    }

    function test_NameIsAlyra() public {
        string memory name = _alyraIsERC20.name();
        assertEq(name, _name);
    }

    function test_SymbolIsALY() public {
        string memory symbol = _alyraIsERC20.symbol();
        assertEq(symbol, _symbol);
    }

    function test_Decimals() public {
        uint256 decimal = _alyraIsERC20.decimals();
        assertEq(decimal, _decimal);
    }

    function test_CheckFirstBalance() public {
        uint256 balanceOfOwner = _alyraIsERC20.balanceOf(_owner);
        assertEq(balanceOfOwner, _initialSupply);
    }

    function test_CheckBalanceAfterTransfer() public {
        uint256 amount = 100;
        // Get the balance of the owner and the recipient before the transfer
        uint256 balanceOwnerBeforeTransfer = _alyraIsERC20.balanceOf(_owner);
        uint256 balanceRecipientBeforeTransfer = _alyraIsERC20.balanceOf(_recipient);
        assertEq(balanceRecipientBeforeTransfer, 0);

        // Owner transfers 100 to the recipient
        vm.prank(_owner);
        _alyraIsERC20.transfer(_recipient, 100);


        uint256 balanceOwnerAfterTransfer = _alyraIsERC20.balanceOf(_owner);
        uint256 balanceRecipientAfterTransfer  = _alyraIsERC20.balanceOf(_recipient);
        console.log(balanceOwnerAfterTransfer); //9999999999999999999900
        console.log(balanceRecipientAfterTransfer); //100

        uint256 expectedBalanceOwnerAfterTransfer = balanceOwnerBeforeTransfer - amount;
        uint256 expectedBalanceRecipientAfterTransfer = balanceRecipientBeforeTransfer + amount;
        console.log(expectedBalanceOwnerAfterTransfer); //9999999999999999999900
        console.log(expectedBalanceRecipientAfterTransfer); //100

        assertEq(balanceOwnerAfterTransfer, expectedBalanceOwnerAfterTransfer);
        assertEq(balanceRecipientAfterTransfer, expectedBalanceRecipientAfterTransfer);
    }

    function test_CheckIfApprovalDone() public {
        uint256 amount = 100;
        uint256 allowanceBeforeApproval = _alyraIsERC20.allowance(_owner, _recipient); //0
        assertEq(allowanceBeforeApproval, 0);

        vm.prank(_owner);
        _alyraIsERC20.approve(_recipient, amount);

        uint256 allowanceAfterApproval = _alyraIsERC20.allowance(_owner, _recipient);
        console.log(allowanceAfterApproval);
        assertEq(allowanceAfterApproval, 100);
    }

    function test_CheckIfTransferFromDone() public {
        uint256 amount = 100;
        vm.prank(_owner);
        _alyraIsERC20.approve(_recipient, amount);

        uint256 balanceOwnerBeforeTransfer  = _alyraIsERC20.balanceOf(_owner);
        uint256 balanceRecipientBeforeTransfer  = _alyraIsERC20.balanceOf(_recipient);

        assertEq(balanceOwnerBeforeTransfer, _initialSupply);
        assertEq(balanceRecipientBeforeTransfer, 0);

        uint256 expectedAllowance = _alyraIsERC20.allowance(_owner, _recipient);
        console.log('ok');
        console.log(expectedAllowance);

        vm.prank(_recipient);
        _alyraIsERC20.transferFrom(_owner, _recipient, amount);
      
        uint256 balanceOwnerAfterTransfer = _alyraIsERC20.balanceOf(_owner);
        uint256 balanceRecipientAfterTransfer = _alyraIsERC20.balanceOf(_recipient);

        uint256 expectedBalanceOwnerAfterTransfer = balanceOwnerBeforeTransfer - amount;
        uint256 expectedBalanceRecipientAfterTransfer = balanceRecipientBeforeTransfer + amount;

        assertEq(expectedBalanceOwnerAfterTransfer, balanceOwnerAfterTransfer);
        assertEq(expectedBalanceRecipientAfterTransfer, balanceRecipientAfterTransfer);
    }
}
