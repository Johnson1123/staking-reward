// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Fund is ERC20("FUND", "FUNDYMBOL") {
    address owner;


    error NOTOWNER();

    constructor() {
        owner = msg.sender;
        _mint(msg.sender, 100000e18);
    }

    function  mintFund(uint32 _amount) external  {
        if(msg.sender != owner){
          revert  NOTOWNER();
        }
        _mint(msg.sender, _amount);
    }
}