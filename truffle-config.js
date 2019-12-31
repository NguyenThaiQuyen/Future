const HDWalletProvider = require('truffle-hdwallet-provider');
const env = require('dotenv').load();

module.exports = {
  networks: {
    development: {
      host: "127.0.0.1",
      port: 7545,
      network_id: "*",
    },

    mainnet: {
      provider: function () {
        return new HDWalletProvider(process.env.MNEMONIC, `https://mainnet.infura.io/v3/${process.env.PROJECT_ID}`)
      },
      skipDryRun: true,
      gas: 2000000,
      gasPrice: 5000000000,
      network_id: 1
    },

    ropsten: {
      provider: () => new HDWalletProvider(process.env.MNEMONIC, `https://ropsten.infura.io/v3/${process.env.PROJECT_ID}`),
      network_id: 3,
      gas: 5600000,
      port: 8454
    },
  },

  // Configure your compilers
  compilers: {
    solc: {
      version: "0.4.25",
      settings: {
        optimizer: {
          enabled: true,
          runs: 200
        },
      }
    }
  }
};
