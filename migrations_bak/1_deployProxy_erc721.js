const { deployProxy } = require('@openzeppelin/truffle-upgrades');

const Erc721 = artifacts.require('ERC721');

module.exports = async function (deployer) {
  // await deployer.deploy(Erc721);
  const instance = await deployProxy(Erc721, { deployer });
  // console.log('Deployed', instance.address);
};


// const { ethers, upgrades } = require("hardhat");

// async function main() {
//   // Deploying
//   const Box = await ethers.getContractFactory("Params");
//   const instance = await upgrades.deployProxy(Box, [42]);
//   await instance.deployed();

//   // Upgrading
//   // const BoxV2 = await ethers.getContractFactory("BoxV2");
//   // const upgraded = await upgrades.upgradeProxy(instance.address, BoxV2);
// }

// main();
