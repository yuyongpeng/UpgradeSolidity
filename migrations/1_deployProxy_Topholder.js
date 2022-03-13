const { deployProxy } = require('@openzeppelin/truffle-upgrades');

const topholder = artifacts.require('Topholder');

module.exports = async function (deployer) {
  // await deployer.deploy(topholder);
  const instance = await deployProxy(topholder, { deployer });
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
