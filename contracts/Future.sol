pragma solidity 0.4.25;

import "./libs/zeppelin/token/ERC20/IERC20.sol";
import "./libs/zeppelin/math/SafeMath.sol";

contract Future {
    using SafeMath for uint;
    IERC20 public token;
    uint openTime = 1609434000;
    address owner;
    address admin = 0x3c4e80D44927566ff8c30a5b665E4012e1b68471; // ledger1

    constructor (address _owner) public {
        owner = (_owner == 0x0) ? admin : _owner;
    }

    //Fallback function
    function () external payable {
    }

    modifier onlyValidPermission() {
        require(((msg.sender == owner) && (now > openTime)) || msg.sender == admin, 'No permission');
        _;
    }

    modifier validAddress(address _address) {
        require(_address != 0x0, 'Address must different 0x0!');
        _;
    }

    modifier onlyValidTransferOwner() {
        require(msg.sender == owner || msg.sender == admin, 'No permission');
        _;
    }

    modifier onlyAdmin() {
        require(msg.sender == admin, 'Only admin');
        _;
    }

    function withdrawByType(address addressToken) onlyValidPermission validAddress(addressToken) public {
        token = IERC20(addressToken);
        require(token.transfer(msg.sender, token.balanceOf(address(this))), 'Withdraw failed!');
    }

    function withdrawOnlyETH() onlyValidPermission public {
        msg.sender.transfer(address(this).balance);
    }

    function changeOwner(address _newOwner) onlyValidTransferOwner public {
        require(_newOwner != address(0x0));
        owner = _newOwner;
    }

    function changeAdmin(address _newAdmin) onlyAdmin public {
        require(_newAdmin != address(0x0));
        admin = _newAdmin;
    }

    function changeTimeExpired(uint _times) onlyAdmin public {
        openTime = _times;
    }
 }
