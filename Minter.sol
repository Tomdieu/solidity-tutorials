// SPDX-License-Identifier:   GPL-3.0
pragma solidity ^0.8.4;

contract Coin {
    // The keyword "public" makes variables
    // accessible from other contracts
    address public minter;
    mapping (address => uint) public balances;

    // Events allow clients to react to specific
    // contract changes you declare
    event Sent(address from,address to,uint amount);

    // Contructor code is only run when the con6tract
    // is created
    constructor(){
        minter = msg.sender;
    } 

    // sends an amount of newly created coins to an address can only be call by the contract created
    function mint(address reciever,uint amount) public {
        require(msg.sender == minter);
        balances[reciever] += amount;
    }

    // Errors allow you to provide information about why an operation failed. They are returned to the caller to an address
    error InsufficientBalance(uint requested,uint available);

    // sends an amount of existing coins
    // from any caller to an address

    function send(address reciever,uint amount) public  {
        if(amount > balances[msg.sender])
            revert InsufficientBalance({
                requested:amount,
                available:balances[msg.sender]
            });
        balances[msg.sender] -= amount;
        balances[reciever] += amount;
        emit Sent(msg.sender,reciever,amount);
    }
}