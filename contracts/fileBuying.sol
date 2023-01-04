// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract storageBuying { 
   enum STATE {Activate, Suspended}
   
   /*address public owner;
   ERC223 public token;
   STATE public State;
   
   function TokenSale(address tokenContractAddress) public
   {
       owner = msg.sender;
       token = ERC20(tokenContractAddress);
       State = STATE.Activate; 
   }
   
   function buyFile() payable public {
       require(State == STATE.Activate);
       token.transfer(msg.sender, msg.value);
   }
   
   function suspend() public 
   {
       require(msg.sender == owner);
       State = STATE.Suspended;
   }
   
   function activate () public
   {
       require(msg.sender == owner);
       State = STATE.Activate;
   }
   
   function withdraw() public
   {
       require(msg.sender = owner);
       owner.transfer(address(this).balance);
   }
   */
}