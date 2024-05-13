// SPDX-License-Identifier: MIT

pragma solidity 0.8.25;

import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../../src/FundMe.sol";
import {DeployFundMe} from "../../script/DeployFundMe.s.sol";
import {FundFundMe, WithdrawFundMe} from "../../script/Interactions.s.sol";

contract InteractionsTest is Test {
    FundMe fundMe;

    address USER = makeAddr("user");

    function setUp() external {
        DeployFundMe deployer = new DeployFundMe();
        fundMe = deployer.run();
        vm.deal(USER, 10 ether);
    }

    function testUserCanFundInteractions() external {
        FundFundMe fundme = new FundFundMe();
        fundme.fundFundMe((address(fundMe)));

        WithdrawFundMe withdraw = new WithdrawFundMe();
        withdraw.withdrawFundMe((address(fundMe)));

        assert(address(fundMe).balance == 0);
    }

}
