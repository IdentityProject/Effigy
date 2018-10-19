pragma solidity ^0.4.19;

import "./effigystone.sol";

contract EffigyBronze is EffigyStone {

  modifier aboveLevel(uint _level, uint _effigyId) {
    require(effigies[_effigyId].level >= _level);
    _;
  }
  
  function changeName(uint _effigyId, string _newName) external aboveLevel(2, _effigyId) {
    require(msg.sender == effigyToOwner[_effigyId]);
    effigies[_effigyId].name = _newName;
  }

  function changeDna(uint _effigyId, uint _newDna) external aboveLevel(20, _effigyId) {
    require(msg.sender == effigyToOwner[_effigyId]);
    effigies[_effigyId].dna = _newDna;
  }
  
  function getEffigiesByOwner(address _owner) external view returns(uint[]) {
  uint[] memory result = new uint[](ownerEffigyCount[_owner]);
uint counter = 0;
    for (uint i = 0; i < effigies.length; i++) {
      if (effigyToOwner[i] == _owner) {
        result[counter] = i;
        counter++;
      }
    }
    return result;
  }

}
