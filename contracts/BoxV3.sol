pragma solidity ^0.8.0;
import "./contracts-upgradeable/proxy/utils/Initializable.sol";
import "./contracts-upgradeable/access/OwnableUpgradeable.sol"; 
contract BoxV3 is Initializable,OwnableUpgradeable {
    uint256 private value;
    uint256 public value2;

    // Emitted when the stored value changes
    event ValueChanged(uint256 newValue);
	function initialize()public initializer{
		__Context_init_unchained();
		__Ownable_init_unchained();
	} 
    // Stores a new value in the contract
    function store(uint256 newValue) public {
        value = newValue;
        emit ValueChanged(newValue);
    }

    function store2(uint256 newValue) public {
        value2 = newValue+1;
        emit ValueChanged(newValue);
    }
 
    // Reads the last stored value
    function retrieve() public view returns (uint256) {
        return value;
    }
}