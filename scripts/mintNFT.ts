// require('dotenv').config();
// const ethers = require('ethers');
// const axios = require('axios');

import { ethers } from "hardhat"

// // Get Alchemy App URL
// const API_KEY = process.env.API_KEY;

// // Define an Alchemy Provider
// const provider = new ethers.providers.AlchemyProvider('sepolia', API_KEY)


// async function getLiskData() {
//     try {
//         // Example endpoint to get the latest block
//         const response = await axios.get('https://testnet.lisk.com/api/blocks/latest');
//         console.log(response.data);
//     } catch (error) {
//         console.error(error);
//     }
// }

// getLiskData();

// // Get contract ABI file
// const contract = require("../artifacts/contracts/Nft.IPFS.sol/CodingFlare.json");

// // Create a signer
// const privateKey = process.env.PRIVATE_KEY
// const signer = new ethers.Wallet(privateKey, provider)

// // Get contract ABI and address
// const abi = contract.abi
// const contractAddress = '0xA4766Ceb9E84a71D282A4CED9fB8Fe93C49b2Ff7'

// // Create a contract instance
// const myNftContract = new ethers.Contract(contractAddress, abi, signer)

// // Get the NFT Metadata IPFS URL
// const tokenUri = "https://gateway.pinata.cloud/ipfs/QmYueiuRNmL4MiA2GwtVMm6ZagknXnSpQnB3z2gWbz36hP"

// // Call mintNFT function
// const mintNFT = async () => {
//     let nftTxn = await myNftContract.mintNFT(signer.address, tokenUri)
//     await nftTxn.wait()
//     console.log(`NFT Minted! Check it out at: https://sepolia.etherscan.io/tx/${nftTxn.hash}`)
// }

// mintNFT()
//     .then(() => process.exit(0))
//     .catch((error) => {
//         console.error(error);
//         process.exit(1);
//     });

async function main() {

    const nftContractAddress = "0x6715D28e510A0B3eF6534B8e27F9a047e7577838"
    const dataURI = "https://azure-implicit-booby-905.mypinata.cloud/ipfs/QmNR3qexwEFdDvrkc1bARsU38diZTuAFSvYgjNMhPXhrsV"
    const myAddress = "0x364c0B0BE42D2F6FbD901746F91d064638ab8dFb"

    const CodingFlareContract = await ethers.getContractAt("IMINTNFTTOKEN", nftContractAddress);

   const _mint = await CodingFlareContract.mintToken(myAddress, dataURI);

   _mint.wait()

    console.log("Successfully");
    
}

main().then(() => process.exit(0)).catch(err => {console.log(err); process.exit(0)})