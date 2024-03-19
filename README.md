## Summary
The following repo contains a contract that works in tandem with the OreMirror contract. The idea of this contract is to allow users to burn two owned ORE NFTs in exchange for one freshly minted BAR NFT. This is accomplished through the function called `forge(uint256 oreId1, uint256 oreId2)`. The user must be the owner of both the ORE NFTs whose IDs they pass to the `forge` function. If they are not the owner, the TX will revert. <br>

There is nothing at the contract level that links the freshly minted NFTs to a BAR type. The idea is to use the on chain ID when it is minted to link it to a Bar type off chain. <br>
<br>
For example: <br>
<br>
Off chain, suppose that the pre-determined combination for Bar A is: ORE ID 1 & ORE ID 2 -> Bar A. Before the `forge` function is called, the Bar ID does not yet exist, so we don't know the ID number to assign to type A. After the `forge` function is called, we now have the ID of the freshly created BAR NFT, and can assign it to Bar A off chain accordingly. This was done in order to avoid hefty gas costs in having to set tons of combinations on chain. <br>
<br>
Misc Info.
```
Blast Sepolia --
Item2 address: 0xE294CE02B25658E670A6646ff3B6155629904BdF
OreMirror:     0xDDCFc252d2Fd666AEd9242cBbD0aa6aab67cF8fa
RPC URL:       "https://sepolia.blast.io
```

## Setup

```
forge install
```

Create a `.env` file and add private key. Follow the template found in `.env.example`.

## Test

```
forge test
```

## Interacting with Contract using Ethers.js

The following is some boiler plate code using Typescript and Ethers.js that can be used to interact with an on chain contract. You can find the `ITEM2_ABI` in the `Item2Abi.json` file within this repo. <br>

Using Ethers v6

```
const main = async () => {
  const provider = new ethers.JsonRpcProvider(RPC_URL);
  const contractAddress = "0x000...";
  const contract = new ethers.Contract(contractAddress, ABI, provider);

  console.log("Contract Function:", await contract.nameOfFunction());
};
main();
```

Using Ethers v5

```
const main = async () => {
  const provider = new ethers.providers.JsonRpcProvider(RPC_URL);
  const contractAddress = "0x000...";
  const contract = new ethers.Contract(contractAddress, ABI, provider);

  console.log("Contract Function:", await contract.nameOfFunction());
};
main();
```
