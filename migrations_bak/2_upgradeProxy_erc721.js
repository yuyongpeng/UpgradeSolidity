const { deployProxy, upgradeProxy } = require('@openzeppelin/truffle-upgrades');

const Erc721 = artifacts.require('ERC721');
const Erc721V2 = artifacts.require('ERC721V2');

module.exports = async function (deployer) {
  // const instance = await deployProxy(Erc721, { deployer });
  // const upgraded = await upgradeProxy(instance.address, Erc721V2, { deployer });
  // 0x122F7b73532e2351674BB3fAAA9b5442E99229E6 是 proxy 协约地址
  const upgraded = await upgradeProxy("0x29aEa20c9BA2a9C35932d60eAf1924B7246ceCa1", Erc721V2, { deployer });
}
