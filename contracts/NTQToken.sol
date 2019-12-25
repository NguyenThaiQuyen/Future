pragma solidity 0.4.25;

import "./libs/zeppelin/token/ERC20/IERC20.sol";
import "./libs/zeppelin/math/SafeMath.sol";
import "./libs/dice/Auth.sol";

contract ERC20 is IERC20 {
    using SafeMath for uint256;

    mapping (address => uint256) internal _balances;
    mapping (address => mapping(address => uint256)) private _allowed;

    event Transfer(address indexed from, address indexed to, uint256 value);

    event Approve(address indexed owner, address indexed spender, uint256 value);

    modifier validAddress(address _to) {
        require(_to != address(0x0), 'Transfer to address OxO!');
        _;
    }

    modifier validValue(address _from, uint256 _value) {
        require(_value <= _balances[_from], 'No enough token!');
        _;
    }

    // check amount money in account
    function balanceOf(address _owner) public view returns (uint256) {
        return _balances[_owner];
    }

    // transfer from address owner to address to amount value
    function transfer(address _to, uint256 _value) validAddress(_to) public returns (bool) {
       _transfer(msg.sender, _to, _value);
        return true;
    }

    // grant for address spender use value token from address owner
    function approve(address _spender, uint256 _value) validAddress(msg.sender) validAddress(_spender) public returns (bool) {
        _approve(msg.sender, _spender, _value);
        return true;
    }

    // check address owner have grant for address spender use amount money?
    function allowance(address owner, address spender) public view returns (uint256) {
        return _allowed[owner][spender];
    }

    function transferFrom(address _from, address _to, uint256 _value) validAddress(_to) validValue(_from, _value) public returns (bool) {
        _transfer(_from, _to, _value);
        _approve(_from, msg.sender, _allowed[_from][msg.sender].sub(_value));
        return true;
    }

    function increaseAllowance(address _spender, uint256 _addValue) validAddress(_spender) public returns (bool) {
        _approve(msg.sender, _spender, _allowed[msg.sender][_spender].add(_addValue));
        return true;
    }

    function decreaseAllowance(address _spender, uint256 _subValue) validAddress(_spender) public returns (bool) {
        _approve(msg.sender, _spender, _allowed[msg.sender][_spender].sub(_subValue));
        return true;
    }

    function _transfer(address _from, address _to, uint _value) validAddress(_to) internal {
        _balances[_from] = _balances[_from].sub(_value);
        _balances[_to] = _balances[_to].add(_value);
        emit Transfer(_from, _to, _value);
    }

    function _approve(address _owner, address _spender, uint _value) validAddress(_spender) validAddress(_owner) internal {
        _allowed[_owner][_spender] = _value;
        emit Approve(_owner, _spender, _value);
    }
}

contract NTQToken is Auth, ERC20 {
    string public constant name = 'NTQToken';
    string public constant symbol = 'NTQ';
    uint8 public constant decimals = 18;
    uint256 public constant totalSupply = (100 * 1e6) * (10 ** uint256(decimals));
    uint private rate = 100;
    event TokenBought(address _owner, uint _amountToken);
    event SetRateBQT(uint _rate);

    constructor() public Auth(msg.sender, msg.sender) {
        _balances[address(this)] = totalSupply;
    }

    function getAddressToken() public view returns (address) {
        return address(this);
    }

    function setRateBQT(uint _rate) onlyMainAdmin public {
        rate = _rate;
        emit SetRateBQT(_rate);
    }

    function getRateBQT() public view returns (uint) {
        return rate;
    }

    function buyToken() public payable returns (bool){
        uint amountToken = msg.value * rate;
        _balances[address(this)] = _balances[address(this)].sub(amountToken);
        _balances[msg.sender] =  _balances[msg.sender].add(amountToken);
        emit TokenBought(msg.sender, amountToken);
        return true;
    }
}