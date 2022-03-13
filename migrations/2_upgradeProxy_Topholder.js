const { deployProxy, upgradeProxy } = require('@openzeppelin/truffle-upgrades');

const topholder = artifacts.require('Topholder');
const topholderV2 = artifacts.require('TopholderV2');

module.exports = async function (deployer) {
  // const instance = await deployProxy(Topholder, { deployer });
  // const upgraded = await upgradeProxy(instance.address, TopholderV2, { deployer });
  // 0x122F7b73532e2351674BB3fAAA9b5442E99229E6 是 proxy 协约地址
  const upgraded = await upgradeProxy("0x925A43e51e2e782dd1d0C188f5096CC8979Af80f", topholderV2, { deployer });
}
