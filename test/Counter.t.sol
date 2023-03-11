// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Counter.sol";

contract CounterTest is Test {
    Counter public counter;

    function setUp() public {
        counter = new Counter(0);
    }

    function test_SetUpState() public {
        assertEq(counter.counter(), 0, "counter should be 0 after setup");
    }

    function testCount() public {
        uint256 result = counter.count();
        assertEq(result, 1, "function count() should return 1");
    }

    function testCountAsOwner() public {
        counter.count();
        assertEq(counter.counter(), 1, "counter should be 1 after call count()");
    }

    function testFailCountAsNotOwner() public {
        vm.prank(address(0));
        counter.count();
    }

    function test_RevertWhen_CountNotOwner() public {
        vm.expectRevert(Unauthorized.selector);
        vm.prank(address(0));
        counter.count();
    }
}
