/** @type import('hardhat/config').HardhatUserConfig */
require("@nomiclabs/hardhat-waffle");
require('solidity-coverage');
require("@nomiclabs/hardhat-truffle5");
module.exports = {
  solidity: "0.8.9",
  paths: {
    artifacts: './src/artifacts',
  },
  networks: {
    hardhat: {
      chainId: 31337,
    }
  },
  mocha: {
    timeout: 70000
  }
};
