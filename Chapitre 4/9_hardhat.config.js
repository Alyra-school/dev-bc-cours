/* Ces lignes importent les modules nécessaires à partir des packages installés dans votre projet. 
Ces modules étendent les fonctionnalités de Hardhat pour faciliter diverses tâches telles que 
la gestion de la configuration, la génération de rapports de gaz et la couverture de code. */
require("@nomicfoundation/hardhat-toolbox");
require("dotenv/config");
require("hardhat-gas-reporter");
require("solidity-coverage");
 // /!\ 
require("@nomicfoundation/hardhat-verify");
 // /!\ 

/* Ces lignes récupèrent les variables d'environnement à partir du fichier .env de votre projet, 
fournissant ainsi des valeurs pour les URL des nœuds de blockchain, la clé privée du compte et 
la clé API d'Etherscan (si elles sont définies). Les || "" assurent que les valeurs sont initialisées 
avec des chaînes vides par défaut si elles ne sont pas fournies dans le fichier .env. */
const SEPOLIA_RPC_URL = process.env.SEPOLIA_RPC_URL || "";
const PRIVATE_KEY = process.env.PRIVATE_KEY || "";
const ETHERSCAN_API_KEY = process.env.ETHERSCAN_API_KEY || "";

module.exports = {
  // Spécifie le réseau par défaut pour Hardhat, qui est défini sur "hardhat".
  defaultNetwork: "hardhat",
  // Définit les configurations pour différents réseaux. Dans cet exemple, 
  // il y a un réseau "sepolia" (chaine de blocs fictive) et un réseau "localhost"
  // pour le développement en local.
  networks: {
    sepolia: {
      url: SEPOLIA_RPC_URL,
      accounts: [`0x${PRIVATE_KEY}`],
      chainId: 11155111,
      blockConfirmations: 6,
    },
    localhost: {
      url: "<http://127.0.0.1:8545>",
      chainId: 31337,
    },
  },
  // Active le rapporteur de gaz (gas reporter) pour afficher les coûts de gaz 
  // lors des déploiements et des transactions.
  gasReporter: {
    enabled: true,
  }, 
  // /!\  Permet de configurer la vérifications sur Etherscan
  etherscan: {
    apiKey: ETHERSCAN_API_KEY,
  },
   // /!\ 
  // Configure les compilateurs Solidity utilisés par Hardhat. 
  // Dans cet exemple, la version "0.8.19" est spécifiée.
  solidity: {
    compilers: [
      {
        version: "0.8.19",
      },
    ],
  },
};
