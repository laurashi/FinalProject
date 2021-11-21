const ApartmentMarket = artifacts.require("ApartmentMarket");

module.exports = function (deployer) {
  deployer.deploy(ApartmentMarket);
};