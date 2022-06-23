// SPDX-License-Identifier: GPL-3.0

pragma solidity >0.4.0 <0.9.0;

contract Auction {
    mapping(address => uint) biddersData;
    uint highestBidAmount;
    address highestBidder;
    address owner;
    uint startTime = block.timestamp;
    uint endTime;
    bool auctionEnded = false;
    constructor(){
        owner = msg.sender;
    }

    //put new bid
    function putBid() public payable{
        //Verify value is not Zero
        uint calculateAmount = biddersData[msg.sender] + msg.value;
        
        require(msg.value > 0 , "Value Cannot be Zero");

        //Check session is not finished
        require(block.timestamp <= endTime , "Aunction is ended");

      
        //Check if Highest Bid 
        require(calculateAmount > highestBidAmount , "You can not bet lesser than highest Bid");
        biddersData[msg.sender] = calculateAmount;
        highestBidAmount = calculateAmount;
        highestBidder = msg.sender;

    } 

    //get contract balance (only for testing)
    function getBidderBid(address _address) public view returns(uint){
        return biddersData[_address];
    }

    //get Highest Bid Amount
    function HighestBidder() public view returns(address){
        return highestBidder;
    }

    //end time
    function putEndTime(uint _endTime) public {
        endTime = _endTime;
    }

    //withdraw bid
    function withdrawBid(address payable _address) public {
        if(biddersData[_address] > 0){
            _address.transfer(biddersData[_address]);
        }
    }

}