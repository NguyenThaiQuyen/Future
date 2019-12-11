const Future = artifacts.require("./Future.sol");
const NTQToken = artifacts.require("./NTQToken.sol");

module.exports = async function(deployer, network) {
  const owner = '0xEa998B81ED2c52e5B40A3DF44DAf0286490c3C28';
  if (network !== 'mainnet') {
    // await deployer.deploy(NTQToken);
    await deployer.deploy(Future, owner);
  }
};
