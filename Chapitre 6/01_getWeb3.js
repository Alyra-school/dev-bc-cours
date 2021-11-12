async loadWeb3() {
   if (window.ethereum) {
     window.web3 = new Web3(window.ethereum) // permet d’initialiser l’objet Web3 en se basant sur le provider injecté dans la page web 
     await window.ethereum.enable() //demande à Metamask de laisser la page web accéder à l’objet web3 injecté
   }
   else if (window.web3) {
     window.web3 = new Web3(window.web3.currentProvider) // si l’objet web3 existe déjà, l’objet Web3 est initialisé en se basant sur le provider du web3 actuel
   }
   else {
     window.alert('Non-Ethereum browser detected. You should consider trying MetaMask!') // message d’erreur si le navigateur ne détecte pas Ethereum
   }
 }
