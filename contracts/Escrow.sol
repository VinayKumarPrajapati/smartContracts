// SPDX-License-Identifier: GPL-3.0

pragma solidity >0.4.0 <0.9.0;

contract Escrow {
    enum State { AWAITING_PAYMENT, AWAITING_DELIVERY, COMPLETE }
    
    State public currState;
    
    address public helpSeeker;
    address payable public helper;
    
    modifier onlyHelpSeeker() {
        require(msg.sender == helpSeeker, "Only Help Seeker can call this method");
        _;
    }
    
    constructor(address _helpSeeker, address payable _helper) public {
        helpSeeker = _helpSeeker;
        helper = _helper;
    }
    
    function deposit() onlyHelpSeeker external payable {
        require(currState == State.AWAITING_PAYMENT, "Already paid");
        currState = State.AWAITING_DELIVERY;
    }
    
    function confirmDelivery() onlyHelpSeeker external {
        require(currState == State.AWAITING_DELIVERY, "Cannot confirm Help");
        helper.transfer(address(this).balance);
        currState = State.COMPLETE;
    }
}