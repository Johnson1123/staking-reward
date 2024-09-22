import { ethers } from "hardhat";
async function deployTOKEN() {
    // const [deployer] = await ethers.getSigners()

    // const CodingFlare = await ethers.getContractFactory("CodingFlare");

    // const deployNFTTOKEN = await CodingFlare.deploy(deployer.address);

    // await deployNFTTOKEN.getDeployedCode()

    // console.log("contarct deploy to address", deployNFTTOKEN)

    const codingFlare = await ethers.deployContract("CodingFlare");

    await codingFlare.waitForDeployment();

     console.log('NFT Contract Deployed at ', +  codingFlare.target);

}

deployTOKEN().then(() => process.exit(0)).catch(err => {console.log(err); process.exit(0)})