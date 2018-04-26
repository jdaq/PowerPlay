# PowerPlay

A smart contract based game of betting. The smart contract is deployed on [Ropsten TestNet](https://ropsten.etherscan.io/address/0x6fa486478077a3343321c537fba7c9436f0a72fc). 

## Rules
Each Player bets 1 ether on any one of the groups.
When a group reaches 10 ethers that group becomes the winner, 
the contract sums up the total ethers of the groups then divides the Ethers to all addresses who made a bet on the winning group, then the game starts a new round.

An address can ONLY bet on one of the groups per round.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine.

### Prerequisites

Node (npm)
Chrome + MetaMask

### Installing

Clone the repo

```
git clone https://github.com/jdaq/PowerPlay
```

Install the dependencies
```
npm install
```

Then run the server
```
npm run dev
```

It should open up a browser.

## Built With

* [Solidity](https://github.com/ethereum/solidity) - The language used for the Smart Contract
* [Node.js](https://github.com/nodejs/node) - Javascript Runtime

## Authors

* **Joshua Aquino** - [Jdaq](https://github.com/jdaq)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

