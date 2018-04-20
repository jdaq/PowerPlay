pragma solidity ^0.4.21;

/**
 * @title Ownable
 * @dev The Ownable contract has an owner address, and provides basic authorization control
 * functions, this simplifies the implementation of "user permissions".
 */
contract Ownable {
  address public owner;

  event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

  /**
   * @dev The Ownable constructor sets the original `owner` of the contract to the sender
   * account.
   */
  function Ownable() public {
    owner = msg.sender;
  }

  /**
   * @dev Throws if called by any account other than the owner.
   */
  modifier onlyOwner() {
    require(msg.sender == owner);
    _;
  }

  /**
   * @dev Allows the current owner to transfer control of the contract to a newOwner.
   * @param newOwner The address to transfer ownership to.
   */
  function transferOwnership(address newOwner) public onlyOwner {
    require(newOwner != address(0));
    emit OwnershipTransferred(owner, newOwner);
    owner = newOwner;
  }

}

/**
 * @title PowerPlay - this contract accepts an ether as a bet
 * A user can enter one of the two groups, if any of the group reaches the jackpotAmount
 * the contract sums up all the bets from each group and divides it into the addresses of the winning group
 * 
 */

contract PowerPlay is Ownable {
	uint jackpotAmount = 10;
    mapping (address => bool) groupA;
    address[] aAddress;
    address[] bAddress;
    mapping (address => bool) groupB;
    uint aFund;
    uint bFund;
    
    modifier notInGroup {
        require(!groupA[msg.sender]);
        require(!groupB[msg.sender]);
        _;
    }

    event WinnerWinnerChickenDinner(string winningGroup);
    
    
    function buyInGroupA() public notInGroup payable {
        require(msg.value == 1 ether);
        aFund ++;
        groupA[msg.sender] = true;
        aAddress.push(msg.sender);
        if (aFund == jackpotAmount) 
            sendWinnings(aAddress);
        emit WinnerWinnerChickenDinner("Group A");
    }
    
    function buyInGroupB() public notInGroup payable {
        require(msg.value == 1 ether);
        bFund ++;
        groupB[msg.sender] = true;
        bAddress.push(msg.sender);
        if (bFund == jackpotAmount)
            sendWinnings(bAddress);
        emit WinnerWinnerChickenDinner("Group B");
    }
    
    function sendWinnings(address[] winners) private {
        uint totalJackpot = aFund + bFund;
        aFund = 0;
        bFund = 0;
        uint winnersCount = winners.length;
        uint winningsPerAddress = totalJackpot / winnersCount;
        for (uint i = 0; i < winners.length; i++) {
            winners[i].transfer(winningsPerAddress * 10**18);
        }
        resetGame();
    }
    
    function getFunds() view public returns (uint, uint) {
        return (aFund, bFund);
    }
    
    function resetGame() private {
        for (uint i = 0; i < aAddress.length; i++) {
            groupA[aAddress[i]] = false;
        }
        
        for (uint j = 0; i < bAddress.length; i++) {
            groupB[bAddress[j]] = false;
        }
    }
    
    function changeJackpotAmount(uint newJackpot) onlyOwner public{
        jackpotAmount = newJackpot;
    }
}
