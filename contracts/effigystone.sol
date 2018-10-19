pragma solidity ^0.4.19;

import "./effigywood.sol";

contract KittyInterface {
  function getKitty(uint256 _id) external view returns (
    bool isGestating,
    bool isReady,
    uint256 cooldownIndex,
    uint256 nextActionAt,
    uint256 siringWithId,
    uint256 birthTime,
    uint256 matronId,
    uint256 sireId,
    uint256 generation,
    uint256 genes
  );
}

contract EffigyStone is EffigyWood {

KittyInterface kittyContract;
  
  function setKittyContractAddress(address _address) external {
    kittyContract = KittyInterface(_address);
  }

 function feedAndMultiply(uint _effigyId, uint _targetDna, string _species) public {
    require(msg.sender == effigyToOwner[_effigyId]);
    Effigy storage myEffigy = effigies[_effigyId];
    _targetDna = _targetDna % dnaModulus;
    uint newDna = (myEffigy.dna + _targetDna) / 2;
    if (keccak256(_species) == keccak256("kitty")) {
      newDna = newDna - newDna % 100 + 99;
    }
    _createEffigy("NoName", newDna);
    }

function feedOnKitty(uint _effigyId, uint _kittyId) public {
    uint kittyDna;
    (,,,,,,,,,kittyDna) = kittyContract.getKitty(_kittyId);
    feedAndMultiply(_effigyId, kittyDna, "kitty");
  }
}
