// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

/// @dev Import Ownable from the OpenZeppelin Contracts library
import "@openzeppelin/contracts/access/Ownable.sol";

/// @title A sample of Apartment Marketplace
/// @author Laura Shi
/// @notice You can use this contract to stimuate on chain apartment purchasing and renting function
contract ApartmentMarket is Ownable {

    /// @dev skuCount Number of apartments in the contract
    uint public skuCount;
    
    mapping (uint => House) public Houses;
    /// <enum State: ForSale, ForRent, Rent>
    enum State { ForSale, ForRent, Rent }
    /// @dev struct House: name, sku, sellprice, rentprice, state, houseowner, and renter
    struct House {
        string name;
        uint sku;
        uint sellprice;
        uint rentprice;
        State state;
        address payable seller;
        address payable houseowner;
        address payable renter;
        /// TypeError: "send" and "transfer" are only available for objects of type "address payable", not "address".
    }
    
    /** 
    Events
    */

    /// @dev <LogForSale event: sku arg>
    event LogForSale(uint sku);
    /// @dev <LogForRent event: sku arg>
    event LogForRent(uint sku);
    /// @dev <LogRent event: sku arg>
    event LogRent(uint sku);

    /** 
    Modifiers
    */
    /// @dev check if the purchase message contains enough value
    modifier paidEnough(uint _sku) { 
        require(msg.value >= Houses[_sku].sellprice); 
        _;
    }
    
    /// @dev cehck if the rent message contains enough value
    modifier rentpaidEnough(uint _sku) {
        require(msg.value >= Houses[_sku].rentprice);
        _;
    }
    
    /// @dev refund them after purchase (why it is before, _ checks for logic before func)
    modifier checkValue(uint _sku) {
        _;
        uint _sellprice = Houses[_sku].sellprice;
        uint amountToRefund = msg.value - _sellprice;
        Houses[_sku].houseowner.transfer(amountToRefund);
        /// TypeError: "send" and "transfer" are only available for objects of type "address payable", not "address".
    }

    /// @dev refund them after rent (why it is before, _ checks for logic before func)        
    modifier checkRent(uint _sku) {
        _;
        uint _rentprice = Houses[_sku].rentprice;
        uint amountToRefund = msg.value - _rentprice;
        Houses[_sku].renter.transfer(amountToRefund);
        /// TypeError: "send" and "transfer" are only available for objects of type "address payable", not "address".
    }
    
    /// @dev check if the state of the apartment is for sale
    modifier forSale(uint _sku) {
        require(Houses[_sku].state == State.ForSale && Houses[_sku].sellprice > 0);
        _;
    }
    /// @dev check if the state of the apartment is for rent
    modifier forRent(uint _sku) {
        require(Houses[_sku].state == State.ForRent && Houses[_sku].rentprice > 0);
        _;
    }

    /// @dev check if the state of the apartment is rent already
    modifier Rent(uint _sku) {
        require(Houses[_sku].state == State.Rent);
        _;
    }
    
    constructor() public {
        /// @dev Initialize the sku count to 0. 
        skuCount = 0;
    }
    /// @dev with onlyOwner, only the contract owner can add apartments to the contract.
    function addHouse(string memory _name, uint _sellprice) 
    public onlyOwner 
    returns (bool) {
    /// @dev 1. Create a new House and put in array
    Houses[skuCount] = House({
    name: _name, 
    sku: skuCount, 
    sellprice: _sellprice, 
    rentprice: 0,
    state: State.ForSale, 
    seller: payable(msg.sender),
    houseowner: payable(address(0)),
    renter: payable(address(0))
    });
    /// @dev 2. Increment the skuCount by one
    skuCount = skuCount + 1;
    /// @dev 3. Update the existing sku's status as for sale
    emit LogForSale(skuCount - 1);
    /// @dev 4. return true
    return true;
    }

    function buyItem(uint sku, uint _rentprice) public payable forSale(sku) paidEnough(sku) checkValue(sku) {
    Houses[sku].houseowner = payable(msg.sender);
    Houses[sku].state = State.ForRent;
    Houses[sku].seller.transfer(Houses[sku].sellprice);
    Houses[sku].rentprice = _rentprice;
    emit LogForRent(sku);
    }

    function rentItem(uint sku) public payable forRent(sku) rentpaidEnough(sku) checkRent(sku) {
    Houses[sku].renter = payable(msg.sender);
    Houses[sku].state = State.Rent;
    Houses[sku].houseowner.transfer(Houses[sku].rentprice);
    emit LogRent(sku);
    }
}
