require('dotenv').config();

module.exports = {
  networks: {
    mumbai: {
      provider: () => new HDWalletProvider(process.env.MNEMONIC, `https://polygon-mumbai.infura.io/v3/${process.env.INFURA_PROJECT_ID}`),
      network_id: 80001,
      gas: 8000000, 
      confirmations: 2,
      timeoutBlocks: 200,
      skipDryRun: true,
    },
  },
  
};
