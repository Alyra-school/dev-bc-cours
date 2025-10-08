/* Ces lignes importent les modules nécessaires à partir des packages installés dans votre projet. 
Ces modules étendent les fonctionnalités de Hardhat pour faciliter diverses tâches telles que 
la gestion de la configuration. */
import type { HardhatUserConfig } from "hardhat/config";

import hardhatToolboxMochaEthersPlugin from "@nomicfoundation/hardhat-toolbox-mocha-ethers";
import { configVariable } from "hardhat/config";
 // /!\ 
import hardhatKeystore from "@nomicfoundation/hardhat-keystore";
 // /!\ 
import hardhatVerify from "@nomicfoundation/hardhat-verify";

const config: HardhatUserConfig = {
  plugins: [hardhatToolboxMochaEthersPlugin, hardhatKeystore, hardhatVerify],
 // ici la configuration de votre API key d'etherscan pour verifier votre contrat
  verify: {
    etherscan: {
      apiKey: "YOURKEY", // a modifier
    },
  },
  solidity: {
    profiles: {
      default: {
        version: "0.8.28",
      },
      production: {
        version: "0.8.28",
        settings: {
          optimizer: {
            enabled: true,
            runs: 200,
          },
        },
      },
    },
  },
   // Définit les configurations pour différents réseaux. Dans cet exemple, 
  // il y a un réseau "sepolia" (chaine de blocs fictive) et un réseau "localhost"
  // pour le développement en local. Dans Sepolia on peut voir l'usage de deux confifVariable qui vont être cherchées dans le keystore
  networks: {
    hardhatMainnet: {
      type: "edr-simulated",
      chainType: "l1",
    },
    hardhatOp: {
      type: "edr-simulated",
      chainType: "op",
    },
    sepolia: {
      type: "http",
      chainType: "l1",
      url: configVariable("SEPOLIA_RPC_URL"),
      accounts: [configVariable("SEPOLIA_PRIVATE_KEY")],
    },
  },
};

export default config;
