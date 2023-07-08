pragma solidity ^0.4.24;

contract Ownable {
    address public owner;

    constructor() public {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    function transferOwnership(address newOwner) public onlyOwner {
        require(newOwner != address(0));
        owner = newOwner;
    }
}

contract ERC20Token {
    function totalSupply() public view returns (uint256);
    function balanceOf(address _owner) public view returns (uint256);
    function transfer(address _to, uint256 _value) public returns (bool);
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool);
    function approve(address _spender, uint256 _value) public returns (bool);
    function allowance(address _owner, address _spender) public view returns (uint256);
    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
}

contract CelsiusToken is ERC20Token, Ownable {
    string public name;
    string public symbol;
    uint8 public decimals;
    uint256 private totalSupply;
    mapping(address => uint256) private balances;
    mapping(address => mapping(address => uint256)) private allowed;
    bool public transfersFrozen;

    event FreezingTransfers();
    event UnfreezingTransfers();

    constructor(string _name, string _symbol, uint8 _decimals, uint256 _initialSupply) public {
        name = _name;
        symbol = _symbol;
        decimals = _decimals;
        totalSupply = _initialSupply * (10 ** uint256(decimals));
        balances[msg.sender] = totalSupply;
    }

    function totalSupply() public view returns (uint256) {
        return totalSupply;
    }

    function balanceOf(address _owner) public view returns (uint256) {
        return balances[_owner];
    }

    function transfer(address _to, uint256 _value) public returns (bool) {
        require(!transfersFrozen);
        require(_to != address(0));
        require(_value <= balances[msg.sender]);

        balances[msg.sender] -= _value;
        balances[_to] += _value;
        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    function transferFrom(address _from, address _to, uint256 _value) public returns (bool) {
        require(!transfersFrozen);
        require(_from != address(0));
        require(_to != address(0));
        require(_value <= balances[_from]);
        require(_value <= allowed[_from][msg.sender]);

        balances[_from] -= _value;
        balances[_to] += _value;
        allowed[_from][msg.sender] -= _value;
        emit Transfer(_from, _to, _value);
        return true;
    }

    function approve(address _spender, uint256 _value) public returns (bool) {
        require(_spender != address(0));
        
        allowed[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    function allowance(address _owner, address _spender) public view returns (uint256) {
        return allowed[_owner][_spender];
    }

    function freezeTransfers() public onlyOwner {
        require(!transfersFrozen);
        transfersFrozen = true;
        emit FreezingTransfers();
    }

    function unfreezeTransfers() public onlyOwner {
        require(transfersFrozen);
        transfersFrozen = false;
        emit UnfreezingTransfers();
    }
}
