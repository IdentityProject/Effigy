pragma solidity ^0.4.19;

import "./effigywood.sol";

contract EffigyStone is EffigyWood {

function feedAndMultiply(uint _effigyId, uint _targetDna) public {
    require(msg.sender == effigyToOwner[_effigyId]);
    Effigy storage myEffigy = effigies[_effigyId];
    _targetDna = _targetDna % dnaModulus;
    uint newDna = (myEffigy.dna + _targetDna) / 2;
    _createEffigy("NoName", newDna);
    }

}
