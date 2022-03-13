# 编译协约
```bash
$ npm run compile
```

# 部署协约
```bash
$ npm run dev
$ npm run bsn_online
$ npm run rinkeby
```

# 初次部署协约（ProxyAdmin.sol  TransparentUpgradeableProxy.sol  Topholder.sol）
```
$ npm run dev
1_deployProxy_Topholder.js
==========================

   Deploying 'Topholder'    # 真实的逻辑协约
   ---------------------
   > transaction hash:    0xe48069bffdc82db87dfdd12b561ad318ad8ff4e938d3d5ebcfecf10a9f5518a6
   > Blocks: 0            Seconds: 0
   > contract address:    0x809160872d78f6C18886a908f42f63EdD76eB0C8
   > block number:        165
   > block timestamp:     1647183082
   > account:             0xC76FC1Dc1113F931Cd7269784456Ff4F916fc57B
   > balance:             98.42979092
   > gas used:            3662959 (0x37e46f)
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.07325918 ETH


   Deploying 'ProxyAdmin'    # 这个是管理协约，部署完成后，会记录在 .openzepplin 目录下的unknow-xxx.json文件中，下次不会在进行部署。需要记录下这个地址。
   ----------------------
   > transaction hash:    0x7650aa406c7933e71b59d7cb6ea9d80946a4d666f580c4f6720d5a1c20f17ea5
   > Blocks: 0            Seconds: 0
   > contract address:    0xC43de78160E88729b1BCe5B461B1Ccef669D9490
   > block number:        166
   > block timestamp:     1647183082
   > account:             0xC76FC1Dc1113F931Cd7269784456Ff4F916fc57B
   > balance:             98.42013652
   > gas used:            482720 (0x75da0)
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.0096544 ETH


   Deploying 'TransparentUpgradeableProxy'    # Proxy协约。以后都是使用这个协约的地址进行操作
   ---------------------------------------
   > transaction hash:    0x62409d89d0d98d02466ac33544f2d7f1daa8bc55a074cd3f5dc49b4c55205426
   > Blocks: 0            Seconds: 0
   > contract address:    0x925A43e51e2e782dd1d0C188f5096CC8979Af80f
   > block number:        167
   > block timestamp:     1647183083
   > account:             0xC76FC1Dc1113F931Cd7269784456Ff4F916fc57B
   > balance:             98.40593016
   > gas used:            710318 (0xad6ae)
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.01420636 ETH

   > Saving artifacts
   -------------------------------------
   > Total cost:          0.09711994 ETH

Summary
=======
> Total deployments:   3
> Final cost:          0.09711994 ETH





# 部署新协约进行升级操作
# 将 2_upgradeProxy_Topholder.js 拷贝到migrations目录中
$ npm run dev

Starting migrations...
======================
> Network name:    'dev'
> Network id:      5777
> Block gas limit: 6721975 (0x6691b7)


2_upgradeProxy_Topholder.js
===========================

   Replacing 'TopholderV2'    # 会部署新的协约，同时会修改 TransparentUpgradeableProxy 中的数据。变更逻辑协约的address
   -----------------------
   > transaction hash:    0x90ad850fc70b9dbdc5188cccf27aa5aab214e5d0012699af1c124fb4de90d3f6
   > Blocks: 0            Seconds: 0
   > contract address:    0x55A85463336Dc0f31bf20D87f930457cC74587c2
   > block number:        174
   > block timestamp:     1647184196
   > account:             0xC76FC1Dc1113F931Cd7269784456Ff4F916fc57B
   > balance:             98.24733958
   > gas used:            3806205 (0x3a13fd)
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.0761241 ETH

   > Saving artifacts
   -------------------------------------
   > Total cost:           0.0761241 ETH

Summary
=======
> Total deployments:   1
> Final cost:          0.0761241 ETH


```


# 可升级协约
```bash
# 拷贝 1_deployProxy.js 到 migrations
$ npm run dev  # ProxyAdmin（管理协约），TransparentUpgradeableProxy（代理协约），ERC721（真实逻辑协约） 
# 会在 .openzeppelin目录下生成对应协约的 address，以后可以通过手动的方式来升级。调用ProxyAdmin.sol 协约的 upgrade(TransparentUpgradeableProxy proxy, address implementation) 方法来实现

# 拷贝 2_upgradeProxy.js 到 migrations
$ npm run dev  # TransparentUpgradeableProxy（代理协约），ERC721（真实逻辑协约） 

```

# 说明
1. 将openzepplin的可升级协约代码拷贝到本项目中contracts
2. 修改了ERC721Upgradeable.sol 的变量和方法为internal，便于子类调用和覆盖

# 依赖安装（目前没有使用这种方法）
```bash
$ cd /home/
$ git clone https://github.com/yuyongpeng/openzeppelin-contracts-upgradeable
$ cd topholder721
$ npm link /home/openzeppelin-contracts-upgradeable
# 在node_module 下可以看到 openzeppelin-solidity的目录，对应 openzeppelin-contracts-upgradeable/package.json 中的 name
```
