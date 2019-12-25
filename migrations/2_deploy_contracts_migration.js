const Future = artifacts.require("./Future.sol");
const NTQToken = artifacts.require("./NTQToken.sol");

module.exports = async function(deployer, network) {
    const accounts = await web3.eth.getAccounts();
    const owner = '0x670604Bb3cd6F9458ffd92372503Cb08e2BCc6Fc'; //amie
  if (network == 'ropsten') {
    // await deployer.deploy(NTQToken);
    await deployer.deploy(Future, owner);
  }
};
