pragma solidity ^0.4.19;

import "./effigyiron.sol";
import "./erc721.sol";

contract EffigySilver is EffigyIron, ERC721 {
 function balanceOf(address _owner) public view returns (uint256 _balance) {
    return ownerEffigyCount[_owner];
  }

  function ownerOf(uint256 _tokenId) public view returns (address _owner) {
    return effigyToOwner[_tokenId];
  }

  function transfer(address _to, uint256 _tokenId) public {

  }

  function approve(address _to, uint256 _tokenId) public {

  }

  function takeOwnership(uint256 _tokenId) public {

  }
}
