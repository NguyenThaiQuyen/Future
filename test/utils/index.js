// const Future = artifacts.require("./Future.sol");
// const NTQToken = artifacts.require("./NTQToken.sol");
//
// let future;
// contract('Future', function (accounts) {
//   describe('I. Admin setRareWinCheckpoint', () => {
//     it('1. fail cause by not admin' , async () => {
//       await catchRevertWithReason(luckyNumberInstance.setRareWinCheckpoint(0, { from: user1 }), 'onlyMainAdmin')
//     })
//     it('2. fail cause by input invalid value' , async () => {
//       await catchRevertWithReason(luckyNumberInstance.setRareWinCheckpoint(99, { from: gameAdmin }), 'rare win is invalid')
//       await catchRevertWithReason(luckyNumberInstance.setRareWinCheckpoint(9501, { from: gameAdmin }), 'rare win is invalid')
//     })
//     it('3. success' , async () => {
//       const rareWinCheckpoint = 100
//       await luckyNumberInstance.setRareWinCheckpoint(rareWinCheckpoint, { from: gameAdmin })
//       const contractHighRollCheckpoint = await luckyNumberInstance.rareWinCheckpoint()
//       contractHighRollCheckpoint.should.be.a.bignumber.that.equal(`${rareWinCheckpoint}`)
//
//     })
//     it('4. should fire event' , async () => {
//       const response = await luckyNumberInstance.setRareWinCheckpoint(100, { from: gameAdmin })
//       util.listenEvent(response, 'RareWinCheckpointSet')
//     })
//   })
//
//   it('accounts[0] should able to change Target1 to Target2 in ProxyContract', async function () {
//     await iProxyContract.changeContract_75b73cc2c1eb(Target2.address);
//     assert.equal(await iProxyContract.getContract_58378af393c6(), iTarget2.address);
//   });
//   it('should able to call Target2 through ProxyContract', async function () {
//     let ProxiedTarget2 = new web3.eth.Contract(iTarget2.abi, iProxyContract.address);
//     await ProxiedTarget2.methods.calculate(4, 5).send({
//       from: accounts[0],
//       to: iProxyContract.address,
//       gas: 5000000
//     });
//     ProxiedTarget2.getPastEvents('allEvents', { fromBlock: 0, toBlock: 'latest' }, function (e, r) {
//       if (!e) {
//         for (let i in r) {
//           if (typeof r[i].event !== 'undefined') {
//             console.log("\t", r[i].event, r[i].returnValues);
//           }
//         }
//       }
//     })
//     assert.equal(await iProxyContract.getContract_58378af393c6(), iTarget2.address);
//     assert.equal((await iProxyContract.data()).valueOf(), 20);
//   });
// });