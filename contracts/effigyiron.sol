pragma solidity ^0.4.19;
import "./effigybronze.sol";
contract EffigyIron is EffigyBronze {
uint randNonce = 0;
uint attackVictoryProbability = 70;
  function randMod(uint _modulus) internal returns(uint) {
    randNonce = randNonce.add(1);
    return uint(keccak256(now, msg.sender, randNonce)) % _modulus;
  }
   function attack(uint _effigyId, uint _targetId) external onlyownerOf(_effigyId) {
    Effigy storage myEffigy = effigies[_effigyId];
    Effigy storage enemyEffigy = effigies[_targetId];
    uint rand = randMod(100);
    if (rand <= attackVictoryProbability) {
      myEffigy.winCount = myEffigy.winCount.add(1);
      myEffigy.level = myEffigy.level.add(1);
      enemyEffigy.lossCount = enemyEffigy.lossCount.add(1);
      feedAndMultiply(_effigyId, enemyEffigy.dna, "effigy");
    } else {
       myEffigy.lossCount = myEffigy.lossCount.add(1);
      enemyEffigy.winCount = enemyEffigy.winCount.add(1);
      _triggerCooldown(myEffigy);
    }
  }
}
