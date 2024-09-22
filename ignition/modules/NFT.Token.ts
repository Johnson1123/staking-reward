import {buildModule} from "@nomicfoundation/hardhat-ignition/modules"

const CodingFlareModule = buildModule("CodingFlareModule", (m) => {
    const codingFlare = m.contract("CodingFlare");

    return {codingFlare}
})

export default CodingFlareModule