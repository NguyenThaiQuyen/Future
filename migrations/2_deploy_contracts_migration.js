const Future = artifacts.require("./Future.sol");
const NTQToken = artifacts.require("./NTQToken.sol");

module.exports = async function(deployer, network) {
    const accounts = await web3.eth.getAccounts();
    const owner = '0x5503df85F30165F984c127930D9110Aa1b3d080A';
  if (network == 'mainnet') {
    //await deployer.deploy(NTQToken);
    await deployer.deploy(Future, owner);
  }
};
