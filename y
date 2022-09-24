// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract tracking{
    address supplier;
    struct item{   //supplier
        uint price;
        string des;
        address buyer;
    }
    struct track{
        uint trackingnumber;
        bool status;
        string location;
        string courierCode;
        uint id;
    }
    mapping(uint=>track) public trackingg;
    mapping(uint => item) public items;
    

    function addItem(uint _price,string memory _des) external {  //customer
        uint counter=1;
        items[counter] = item(_price,_des,address(0));
        counter++;
    }
    function buy(uint _id) external payable {
        require(msg.value == items[_id].price,"send the required amount" );  //customer
        payable(supplier).transfer(msg.value);
        items[_id].buyer=msg.sender;
    }
    function set_track(uint _trackingnumber, bool _status,string memory _location,string memory _courierCode,uint _id)external {
        trackingg[_id] = track(_trackingnumber,_status,_location,_courierCode,_id);
    }
}
