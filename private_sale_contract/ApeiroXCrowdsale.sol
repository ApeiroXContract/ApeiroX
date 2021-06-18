pragma solidity ^0.4.24;

import "./CappedCrowdsale.sol";

contract ApeiroXCrowdsale is CappedCrowdsale {
    uint256 internal constant ethCap = 20000 ether;
    uint256 internal constant oneEthToTokens = 25000000;
    address private _mywal;
    address private _mytok;
    
    modifier onlyOwner() {	
        require( msg.sender == _mywal );
        _;
    }
    
    constructor(address _wallet, ERC20 _token) public
        Crowdsale(oneEthToTokens, _wallet, _token)
        CappedCrowdsale(ethCap)
    {
        _mywal = msg.sender;
        _mytok = _token;
    }
    
    function withdrawUnsoldTokens(uint256 val) onlyOwner external
    {
        // require(msg.sender == _mywal);
        token.safeTransfer(_mywal, val);
    }
}