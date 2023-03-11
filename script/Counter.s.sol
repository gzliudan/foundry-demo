// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/Counter.sol";

contract CounterScript is Script {
    address internal deployer;
    string internal mnemonic;

    function saveContract(string memory network, string memory name, address addr) public {
        string memory filename = string.concat(string.concat("deploy/", network), ".json");

        string memory childObj = "child";
        vm.serializeString(childObj, "name", name);
        string memory childJson = vm.serializeAddress(childObj, "address", addr);

        string memory rootObj = "root";
        vm.serializeString(rootObj, "network", network);
        string memory rootJson = vm.serializeString(rootObj, name, childJson);

        vm.writeJson(rootJson, filename);
    }

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        Counter c = new Counter(0);
        console.log("Counter deployed on %s", address(c));
        vm.stopBroadcast();

        saveContract("goerli", "Counter", address(c));
    }
}
