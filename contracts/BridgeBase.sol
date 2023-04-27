pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Bridge is Ownable {
    IERC20 public token;                        // token controlled by bridge
    uint256 public nonce;                       // current outgoing transaction
    mapping(uint256 => bool) processedNonces;   // mapping of incoming transactions

    /// event used for listener to signal token transferring
    event Transfer(
        address from,
        address to,
        uint256 amount,
        uint256 date,
        uint256 nonce,
        bool isMint
    );

    constructor(address _token){
        token = _token;
    }

    function transfer(address to, uint256 amount) external {
        // remove token from circulation on current network
        token.burn(msg.sender, amount);
        
        // emit event to listener
        emit Transfer(
            msg.sender,
            to,
            amount,
            block.timestamp,
            nonce++,
            false
        )
    }

    function receive(address to, uint256 amount, uint256 _nonce) external onlyOwner {
        require(!processedNonces[_nonce], "transfer already processed");
        processedNonces[_nonce] = true;

        // add tokens to circulation
        token.mint(to, amount);
        
        // emit event 
        emit Transfer(
            msg.sender,
            to,
            amount,
            block.timestamp,
            _nonce,
            true
        )
    }

}