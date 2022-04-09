//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// import "hardhat/console";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract CryptoVest {
    uint constant private conversionRate = 20;

    struct Safelock {
        uint amount;
        uint duration;
        uint blockNumberAtCreation;
        uint interest;
        string reason;
        string status;
        address owner;
    }

    mapping(address => Safelock[]) safelocks;

    event safelockCreated(
        uint amount,
        uint duration,
        uint blockNumberAtCreation,
        uint interest,
        string reason,
        string status,
        address owner);

    event safelockUpdated(address sender, uint newDuration);

    event fundWallet(address sender, uint amount, string tokenName);

    modifier onlyOwner(address owner) {
        require(msg.sender == owner, "Only owner can call this function.");
        _;
    }

    modifier onlyIfSafelockHasElapsed(uint duration) {
        require(duration <= block.timestamp, "This function can only be called after safelock duration has elapsed");
        _;
    }

    function createSafelock(uint duration, string memory reason) payable external {
        uint tokenEquivalent = msg.value * conversionRate;
        Safelock memory safelock = Safelock(msg.value, duration, block.number, 30, reason, "ongoing", msg.sender);
    }

    function getSafeLocks(address loggedInUser) external view onlyOwner(loggedInUser) returns (Safelock[] memory) {
        return safelocks[msg.sender];
    }

    function getInterest(address loggedInUser, Safelock memory safeLock) external onlyOwner(loggedInUser) returns (uint) {
        return 10;
    }
}
