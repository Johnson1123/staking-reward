// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract CodingFlare is ERC721URIStorage {
    uint256 private tokenId;

    address owner;

    error NOTOWNER();

    constructor() ERC721("CodingFlare", "CFE") {
        owner = msg.sender;
    }


    function createCFEToken(address _tokenOwner, string memory tokenURI) external returns(uint256){

            if(msg.sender != owner) {
                revert NOTOWNER();
            }

            tokenId++;

            uint256 id = tokenId;

            _mint(_tokenOwner, id);

            _setTokenURI(id, tokenURI);

            return id;
    }

    
}
