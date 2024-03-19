## Setup

```
forge install
```

Create a `.env` file and add private key. Follow the template found in `.env.example`.

## Test

```
forge test
```

## Interacting with Contrac Using Ethers.js

The following is some boiler plate code using Typescript and Ethers.js that can be used to interact with the Item2.sol contract. You can find the `ITEM2_ABI` in the `Item2Abi.json` file within this repo. <br>

Using ethers v6

```
const main = async () => {
  const provider = new ethers.JsonRpcProvider("https://sepolia.blast.io");
  const ITEM2_ADDRESS = "0x67C2FBcEa5dB736682f893333C4138e0aD34C14F";
  const item2 = new ethers.Contract(ITEM2_ADDRESS, ITEM2_ABI, provider);

  console.log("Item2 name:", await item2.name());
};
main();
```

Using Ethers v5

```
const main = async () => {
  const provider = new ethers.providers.JsonRpcProvider(
    "https://sepolia.blast.io"
  );
  const ITEM2_ADDRESS = "0x67C2FBcEa5dB736682f893333C4138e0aD34C14F";
  const item2 = new ethers.Contract(ITEM2_ADDRESS, ITEM2_ABI, provider);

  console.log("Item2 name:", await item2.name());
};
main();
```
