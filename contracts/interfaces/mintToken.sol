// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.17;

interface IMINTNFTTOKEN {
    function mintToken(address _tokenOwner, string memory _tokenURL) external;
}