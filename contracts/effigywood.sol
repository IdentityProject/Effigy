pragma solidity ^0.4.19;

import "./ownable.sol";
contract EffigyWood is Ownable {

    event NewEffigy(uint effigyId, string name, uint dna);

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    struct Effigy {
        string name;
        uint dna;
    }

    Effigy[] public effigies;
    
    mapping (uint => address) public effigyToOwner;
    mapping (address => uint) ownerEffigyCount;

    function _createEffigy(string _name, uint _dna) internal {
        
        uint id = effigies.push(Effigy(_name, _dna)) - 1;
        effigyToOwner[id] = msg.sender;
        ownerEffigyCount[msg.sender]++;
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
