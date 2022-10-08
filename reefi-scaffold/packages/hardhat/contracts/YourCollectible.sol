// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;  //Do not change the solidity version as it negativly impacts submission grading

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";


contract YourCollectible is
    Ownable,
    ERC721,
    ERC721Enumerable,
    ERC721URIStorage
{

    using Counters for Counters.Counter;
    Counters.Counter private _tokenIdCounter;
    Counters.Counter private _funderIdCounter;

    mapping(uint256 => address) private _funders;

    uint256 _impactScore = 0;
    address _projectOwner;
    mapping(uint256 => uint256) private _score; //old score

    constructor() ERC721("ImpactNFT", "INFT") {}

    function _baseURI() internal pure override returns (string memory) {
        return "https://ipfs.io/ipfs/";
    }

    function mintItem(address to, string memory uri) public payable returns (uint256) {
        _tokenIdCounter.increment();
        uint256 tokenId = _tokenIdCounter.current();
        _safeMint(to, tokenId);
        //_setTokenURI(tokenId, uri);
        changeTokenURIBasedOnScore(tokenId);
        return tokenId;
    }

    function changeTokenURIBasedOnScore(uint256 tokenId) private{
      string memory uri;
      if (_impactScore<1000) uri = "QmfVMAmNM1kDEBYrC2TPzQDoCRFH6F5tE1e9Mr4FkkR5Xr";
      if (_impactScore>=1000 && _impactScore<2000) uri = "QmVHi3c4qkZcH3cJynzDXRm5n7dzc9R9TUtUcfnWQvhdcw";
      if (_impactScore>=2000) uri = "QmcvcUaKf6JyCXhLD1by6hJXNruPQGs3kkLg2W1xr7nF1j";
      _setTokenURI(tokenId, uri);
    }

    /*function changeTokenURI(uint256 tokenId, string memory uri) public{
        _setTokenURI(tokenId, uri);
    }*/

    function updateNFT(uint256 tokenId) public{ //change later to onlyOwner
        changeTokenURIBasedOnScore(tokenId);
    }

    function getScore(uint256 tokenId) public view returns (uint256){
        return _score[tokenId];
    }

    // The following functions are overrides required by Solidity.

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId
    ) internal override(ERC721, ERC721Enumerable) {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function _burn(uint256 tokenId)
        internal
        override(ERC721, ERC721URIStorage)
    {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }

    function updateImpactScore(uint256 score) public //change later to datafeed address
    {
        _impactScore = score;
    }

    function getImpactScore() public view returns(uint256)
    {
        return _impactScore;
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }

    function moveFunds(address payable _to, uint256 amount) public payable { //later to onlyOwner or projectOwner
    // Call returns a boolean value indicating success or failure.
    // This is the current recommended method to use.
        require(address(this).balance >= amount);
        (bool sent, bytes memory data) = _to.call{value: amount}("");
        require(sent, "Failed to send Ether");
    }

    function fundProject() external payable
    {

    }
}
