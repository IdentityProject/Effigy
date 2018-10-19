pragma solidity ^0.4.19;

contract EffigyRegistry {

    event NewEffigy(uint effigyId, string name, uint dna);

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    struct Effigy {
        string name;
        uint dna;
    }

    Effigy[] public effigies;

    function _createEffigy(string _name, uint _dna) private {
        
        uint id = effigies.push(Effigy(_name, _dna)) - 1;
        NewEffigy(id, _name, _dna);
    } 

    function _generateRandomDna(string _str) private view returns (uint) {
        uint rand = uint(keccak256(_str));
        return rand % dnaModulus;
    }

    function createRandomEffigy(string _name) public {
        uint randDna = _generateRandomDna(_name);
        _createEffigy(_name, randDna);
    }

}
