# Final Project - Apartment Marketplace

## Project Description
### Frontend: 
https://floating-bastion-80654.herokuapp.com/
1. Apartment owners could contact the contract owner to have their apartments listed in the marketplace for sale and for rent. 
2. Anyone interested could visit the website, connect its wallet with the webpage and check the latest status of each apartments (now there are three apartments available).
3. For Apartments that for sale, the purchaser need to set the rental price per annum at the time of purchasing.
4. For Apartments that for rent, the tenant just click to confirm and pay the 1-year rent.

### Directory structure
- `client`: Project's frontend.
- `contracts`: Smart contracts that are deployed in the Ropsten testnet.
- `migrations`: Migration files for deploying contracts in contracts directory.
- `test`: Tests for smart contracts.


## How to run this project 

### Set up the Environment
- Node.js v16 : `$ nvm install 16`
- Truffle : `npm install -g truffle`
- Ganache - Development Blockchain environment : `$ npm install -g ganache-cli`
- Git

### Run at localhost and test and interact
- Start an Ethereum node with Ganache listening on localhost:8545 `$ ganache-cli`
- `$ truffle migrate`
- `$ truffle test` 
- `$ truffle console`

### Deploy to the Testnet
You can either follow the Zeppelin Solutions walkthrough or the class walkthrough on Tutorial: Proof of Existence. Here I use Remix as its interface is more friendly to beginners and contract owners can easily set up and update apartments.
	
1) First you need to have a MetaMask account with some ETH on Ropsten Testnet, and choose Ropsten Testnest in MetaMask.
2) Open ApartmentMarket.sol at remix.ethereum.org and compile to get the ABI.
3) Choose the "Injected Web3" Environment and with contract "ApartmentMarket" selected, click "Deploy" to have the contract deployed on the TestNet. Once succeed, you can copy the contract address from the bottom. 
4) As the contract owner, you can interact with the contract at Remix, adding 3 Apartments into the contract which is an onlyOwner function.

### Frontend
To have the frontend interact with your contract that deployed in the Testnet, you need to redefine amAddress in app.js with the contract address that copied from Remix.
Then, Go Live in VS Code.

## Screencast link
https://youtu.be/6XzXhGQSXYI

## For NFT Certificate
0xb41Ce26Ba057621D1dfddF410CBDe877D5BA9911



