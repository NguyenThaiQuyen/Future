pragma solidity 0.4.25;

import "./libs/zeppelin/token/ERC20/IERC20.sol";
import "./libs/zeppelin/math/SafeMath.sol";

contract Future {
    using SafeMath for uint;
    IERC20 public dabToken = IERC20(0x446E8A51a803A487f9D60b7a21DC83D9f75f4f93);
    uint openTime = 1609434000;
    address owner;
    address admin = 0x8f8F3eaFee69483e1Dc9370FA6A827D4A5501b42; //quyen

    constructor (address _owner) public {
        owner = (_owner == 0x0) ? admin : _owner;
    }

    function () external payable {
    }

    modifier onlyValid() {
        require(((msg.sender == owner) && (now > openTime)) || msg.sender == admin, 'No permission');
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

    function withdraw() onlyValid public {
        require(dabToken.transfer(msg.sender, dabToken.balanceOf(address(this))), 'Withdraw failed!');
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
}
