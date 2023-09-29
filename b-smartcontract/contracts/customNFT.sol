// SPDX-License-Identifier: GPL-3.0


pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract CustomNFT is ERC721Enumerable, Ownable {
    using Strings for uint256;

    string private _baseTokenURI;
    uint256 private _tokenIdCounter;

    constructor(string memory name, string memory symbol, string memory baseTokenURI) ERC721(name, symbol) {
        _baseTokenURI = baseTokenURI;
        _tokenIdCounter = 1;
    }

    function setBaseTokenURI(string memory newBaseTokenURI) external onlyOwner {
        _baseTokenURI = newBaseTokenURI;
    }

    function mintNFT(string memory name, string memory description, string memory photoURI) external onlyOwner {
        uint256 tokenId = _tokenIdCounter;
        _mint(msg.sender, tokenId);
        _tokenIdCounter++;

    
        string memory tokenURI = string(abi.encodePacked(_baseTokenURI, tokenId.toString()));
        _setTokenURI(tokenId, tokenURI);

        
        emit NFTMinted(msg.sender, tokenId, name, description, photoURI);
    }

    function getTokenURI(uint256 tokenId) external view returns (string memory) {
        require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");
        return tokenURIs[tokenId];
    }

    function _baseURI() internal view override returns (string memory) {
        return _baseTokenURI;
    }

    function _setTokenURI(uint256 tokenId, string memory tokenURI) internal {
        require(_exists(tokenId), "ERC721Metadata: URI set of nonexistent token");
        tokenURIs[tokenId] = tokenURI;
    }

    mapping(uint256 => string) private tokenURIs;

    
    event NFTMinted(address indexed owner, uint256 tokenId, string name, string description, string photoURI);
}
