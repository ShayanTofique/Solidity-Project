// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.0;

contract Staking{
uint256 _current_Time = block.timestamp;
constructor() payable{

}
    struct Stakerperson {
     address stakeAddress;
     uint256 stakingAmount;
     uint256 amountWithdraw;
     uint256 profit;
     uint256 stakingDuration;    
    }
    Stakerperson[] public stake;
 mapping(address => Stakerperson) public Stakermapping;

 function stakers() payable public{
     require(msg.value == 4 ether , "Value should be greater than 1 Ether");
     if(Stakermapping[msg.sender].stakingAmount == 4 ether){
         revert("you need to wihdraw before staking more");
     }
        Stakermapping[msg.sender] = Stakerperson({
         stakeAddress : msg.sender,
         stakingAmount : msg.value,
         profit :Stakermapping[msg.sender].profit,
         amountWithdraw:Stakermapping[msg.sender].amountWithdraw,
         stakingDuration: block.timestamp
});
 }

 function withdraw() public {
     Stakerperson memory person =  Stakermapping[msg.sender];
     require(person.stakingAmount == 4 ether , "invalid balance");
     uint currentTime = block.timestamp;
     uint duration = currentTime - person.stakingDuration;
     uint256 profit; 
     if(duration > 60 && duration < 120){
    profit =  1 ether;
     }
     else if(duration > 120 && duration < 180){
         profit = 1.5 ether;
     }
     else if(duration > 180){
         profit = 2 ether;
     }
     (bool sent,) = payable(person.stakeAddress).call{value: person.stakingAmount + profit}("");
     if(!sent ){
         revert("tx failed");
     }
    Stakermapping[msg.sender] = Stakerperson({
         stakingAmount :0,
         stakeAddress : msg.sender,
         profit: person.profit + profit,
         amountWithdraw : person.stakingAmount,
         stakingDuration : 0
     });
 }
}
