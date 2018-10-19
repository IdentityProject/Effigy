pragma solidity ^0.4.19;
import "./effigybronze.sol";
contract EffigyIron is EffigyBronze {
uint randNonce = 0;
uint attackVictoryProbability = 70;
  function randMod(uint _modulus) internal returns(uint) {
    randNonce++;
    return uint(keccak256(now, msg.sender, randNonce)) % _modulus;
  }
   function attack(uint _effigyId, uint _targetId) external ownerOf(_effigyId) {
    Effigy storage myEffigy = effigies[_effigyId];
    Effigy storage enemyEffigy = effigies[_targetId];
    uint rand = randMod(100);
  }
}
