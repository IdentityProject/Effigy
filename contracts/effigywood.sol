pragma solidity ^0.4.19;

import "./ownable.sol";
import "./safemath.sol";
contract EffigyWood is Ownable {

using SafeMath for uint256;
using SafeMath32 for uint32;
  using SafeMath16 for uint16;

    event NewEffigy(uint effigyId, string name, uint dna);

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;
    uint cooldownTime = 1 days;

    struct Effigy {
        string name;
        uint dna;
        uint32 level;
        uint32 readyTime;
        uint16 winCount;
      uint16 lossCount;
    }

    Effigy[] public effigies;
    
    mapping (uint => address) public effigyToOwner;
    mapping (address => uint) ownerEffigyCount;

    function _createEffigy(string _name, uint _dna) internal {
        
       uint id = effigies.push(Effigy(_name, _dna, 1, uint32(now + cooldownTime), 0, 0)) - 1;
        effigyToOwner[id] = msg.sender;
        ownerEffigyCount[msg.sender] = ownerEffigyCount[msg.sender].add(1);
        NewEffigy(id, _name, _dna);
    } 

    function _generateRandomDna(string _str) private view returns (uint) {
        uint rand = uint(keccak256(_str));
        return rand % dnaModulus;
    }

    function createRandomEffigy(string _name) public {
        require(ownerEffigyCount[msg.sender] == 0);
        uint randDna = _generateRandomDna(_name);
        _createEffigy(_name, randDna);
    }

}

contract EffigyStone is EffigyWood {
}
