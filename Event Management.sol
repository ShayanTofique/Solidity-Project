// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract EventContract{
    struct Event{
        address organizer;
        string name;
        uint date;
        uint prize;
        uint noOftickets;
        uint ticketRemain;
    }
    mapping(uint=>Event) public Events;
    mapping(address=>mapping(uint=>uint)) tickets;
    uint eventId;

    function createEvent(string memory _name,uint _date,uint _prize,uint _noOftickets) external {
        require(_date>block.timestamp,"you can organize event for future date only!");
        require(_noOftickets>0,"No of tickets must be greater than zero!");

        Events[eventId] = Event(msg.sender,_name,_date,_prize,_noOftickets,_noOftickets);
        eventId++;
    }
    function buyTicket(uint _eventId,uint Quantity) external payable {
        require(Events[_eventId].date != 0,"this event does'nt exit");
        require(Events[_eventId].date > block.timestamp,"this event has already happend");
        require(msg.value == Events[_eventId].prize*Quantity,"send the required Amount");
        require(Events[_eventId].ticketRemain>0 ,"no tickets available");
        Events[_eventId].ticketRemain-=Quantity;
        tickets[msg.sender][_eventId]+=Quantity;
    }
    function transferTicekts(uint _eventId,uint Quantity,address _addr) external{
        require(Events[_eventId].date != 0,"this event does'nt exist");
        require(Events[_eventId].date > block.timestamp,"this event has already happend");
        require(tickets[msg.sender][_eventId]>=Quantity,"you do not have enough tickets to transfer");
        tickets[msg.sender][_eventId]-=Quantity;
        tickets[_addr][_eventId]+=Quantity;
    }
}