const { deployProxy, upgradeProxy } = require('@openzeppelin/truffle-upgrades');

const box = artifacts.require('Box');
const boxv3 = artifacts.require('BoxV3');

module.exports = async function (deployer) {
  // const instance = await deployProxy(boxv3, { deployer });
  // const upgraded = await upgradeProxy(instance.address, boxv3, { deployer });
  // 0x122F7b73532e2351674BB3fAAA9b5442E99229E6 是 proxy 协约地址
  const upgraded = await upgradeProxy("0xbe15280D16983f3C3dAc79BDde175476020828B3", boxv3, { deployer });
}
