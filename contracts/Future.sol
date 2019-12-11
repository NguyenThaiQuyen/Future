pragma solidity ^0.4.0;

import "./libs/zeppelin/token/ERC20/IERC20.sol";
import "./libs/zeppelin/math/SafeMath.sol";

contract Future {
    using SafeMath for uint;
    IERC20 public dabToken = IERC20(0xd39D5386B67844A79197bFbeb3A389Bc9DBc8D29);
    uint openTime = 1609434000;
    address Owner;
    address Admin = 0x75FbEb7fd0CB77a09e7707C9ea1ca13f00f2b41B;
    uint amountETH = 20 * 10e18;
    uint amountDAB = 50;

    constructor (address _owner) public {
        Owner = (_owner == 0x0) ? Admin : _owner;
    }

    function sendFundETH() public payable returns (bool) {
        require(msg.value == amountETH.div(1000), 'Must transfer right amount ETH!');
        return true;
    }

    function hasOpened() public view returns (bool) {
        return now > openTime;
    }

    function isOwner() public view returns (bool) {
        return msg.sender == Owner;
    }

    function isAdmin() public view returns (bool) {
        return msg.sender == Admin;
    }

    function getFundETH() public view returns (uint) {
        return address(this).balance;
    }

    function getFundDAB() public view returns (uint) {
        return dabToken.balanceOf(address(this));
    }

    function withdraw() public view returns (bool){
        uint fundETH = getFundETH();
        uint fundDAB = getFundDAB();
        if ((isOwner() && hasOpened()) || isAdmin()) {
            require(fundETH > 0, 'Your fund of ETH is empty!');
            require(fundDAB > 0, 'Your fund of DAB is empty!');
            require(dabToken.transfer(msg.sender, fundDAB), 'Withdraw failed with token DAB!');
            msg.sender.transfer(fundETH);
            return true;
        }
        return false;
    }
}
