const BN = require('bn.js')
const Burn = artifacts.require("./Burn.sol")
const LuckyNumber = artifacts.require("./LuckyNumber.sol")
const MockDABANKING = artifacts.require("./MockDABANKING.sol")

require('chai')
  .use(require('chai-as-promised'))
  .use(require('chai-bn')(BN))
  .should()

async function initContracts(accounts) {
  const mainAdmin = accounts[accounts.length - 1]
  const gameAdmin = accounts[0]
  const seed = process.env.SEED
  const burnInstance = await Burn.new()
  const luckyNumberInstance = await LuckyNumber.new(mainAdmin, gameAdmin, burnInstance.address, seed)
  const mockDABANKINGInstance = await MockDABANKING.new(accounts, luckyNumberInstance.address)
  await luckyNumberInstance.setDabToken(mockDABANKINGInstance.address)
  return {
    luckyNumberInstance,
    mockDABANKINGInstance
  }
}

const accountsMap = {}

function getAccounts(accounts) {
  accountsMap.gameAdmin = accounts[0]
  accountsMap.mainAdmin = accounts[accounts.length - 1]
  for (let i = 1; i < accounts.length - 1; i += 1) {
    accountsMap[`user${i}`] = accounts[i]
  }
  return accountsMap
}

function listenEvent(response, eventName, index = 0) {
  assert.equal(response.logs[index].event, eventName, eventName + ' event should fire.');
}

module.exports = {
  getAccounts,
  initContracts,
  listenEvent,
  BN
}
