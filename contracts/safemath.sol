pragma solidity ^0.4.19;
// @author Zander Kiel Identity Network 2018
// @title Effigy 2018 
import "./effigyiron.sol";
import "./erc721.sol";

contract EffigySilver is EffigyIron, ERC721 {
mapping (uint => address) effigyApprovals;
 function balanceOf(address _owner) public view returns (uint256 _balance) {
    return ownerEffigyCount[_owner];
  }

  function ownerOf(uint256 _tokenId) public view returns (address _owner) {
    return effigyToOwner[_tokenId];
  }
  
  
  function _transfer(address _from, address _to, uint256 _tokenId) private {
     ownerEffigyCount[_to] = ownerEffigyCount[_to].add(1);
    ownerEffigyCount[_from] = ownerEffigyCount[_from].sub(1);
    effigyToOwner[_tokenId] = _to;
    Transfer(_from, _to, _tokenId);
  }

  function transfer(address _to, uint256 _tokenId) public onlyownerOf(_tokenId) {
    _transfer(msg.sender, _to, _tokenId);

  }

   function approve(address _to, uint256 _tokenId) public onlyownerOf(_tokenId) {
    effigyApprovals[_tokenId] = _to;
    Approval(msg.sender, _to, _tokenId);

  }

  function takeOwnership(uint256 _tokenId) public {
 require(effigyApprovals[_tokenId] == msg.sender);
    address owner = ownerOf(_tokenId);
    _transfer(owner, msg.sender, _tokenId);
  }
}
