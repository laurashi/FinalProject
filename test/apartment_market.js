const ApartmentMarket = artifacts.require("ApartmentMarket");

let { catchRevert } = require("./ExceptionHelp.js");
/*
 * uncomment accounts to access the test accounts made available by the
 * Ethereum client
 * See docs: https://www.trufflesuite.com/docs/truffle/testing/writing-tests-in-javascript
 */
contract("ApartmentMarket", function (accounts) {

  const [_owner, alice, bob] = accounts;
  const emptyAddress = "0x0000000000000000000000000000000000000000";
  const price = "1000";
  const excessAmount = "2000";
  const name = "book";

  
  it("should assert true", async function () {
    await ApartmentMarket.deployed();
    return assert.isTrue(true);
  });

  it("skuCount has an initial value of 0", async () => {
    // get the contract that's been deployed
    const amInstance = await ApartmentMarket.deployed();

    // verify skuCount has an intial value of 0
    const amSkuCount = await amInstance.skuCount.call();
    assert.equal(amSkuCount, 0, 'Initial skuCount state should be zero');
  });

  it("should error when address other than owner addHouse", async () => {
    // get the contract that's been deployed
    const amInstance = await ApartmentMarket.deployed();
    // revert if addHouse is made by address other than the contract owner
    await catchRevert(amInstance.addHouse(name, price, { from: alice }));
  });

  it("should emit a LogForSale event when an apartment is added", async () => {
    // get the contract that's been deployed
    const amInstance = await ApartmentMarket.deployed();
    // test if LogForSale event is emitted
    let eventEmitted = false;
    const tx = await amInstance.addHouse(name, price, { from: _owner });
    if (tx.logs[0].event == "LogForSale") {
      eventEmitted = true;
      }
    assert.equal(eventEmitted, true, "adding an item should emit a For Sale event");
  });

  it("should error when not enough value is sent when purchasing an apartment", async () => {
    // get the contract that's been deployed
    const amInstance = await ApartmentMarket.deployed();
    // revert if not pay enough
    await catchRevert(amInstance.buyItem(0, 1, { from: bob, value: 10 }));
  });

  it("should emit LogForRent event when and apartment is sold", async () => {
    // get the contract that's been deployed
    const amInstance = await ApartmentMarket.deployed();
    // test if LogForRent event is emitted
    var eventEmitted = false;
    const tx = await amInstance.buyItem(0, 50, { from: alice, value: excessAmount });
    if (tx.logs[0].event == "LogForRent") {
      eventEmitted = true;
    }
    assert.equal(eventEmitted, true, "Selling an apartment should emit a ForRent event");
  });

  it("should emit LogRent event when and apartment is rent", async () => {
    // get the contract that's been deployed
    const amInstance = await ApartmentMarket.deployed();
    // test if LogRent event is emitted
    var eventEmitted = false;
    const tx = await amInstance.rentItem(0, { from: bob, value: excessAmount });
    if (tx.logs[0].event == "LogRent") {
      eventEmitted = true;
    }
    assert.equal(eventEmitted, true, "Renting an aparatment should emit a Rent event");
  });


  
});
