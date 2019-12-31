const Future = artifacts.require("./Future.sol");
const NTQToken = artifacts.require("./NTQToken.sol");

module.exports = async function(deployer, network) {
    const accounts = await web3.eth.getAccounts();
    const owner = '0x8f8F3eaFee69483e1Dc9370FA6A827D4A5501b42';
  if (network == 'ropsten') {
    //await deployer.deploy(NTQToken);
    await deployer.deploy(Future, owner);
  }
};
