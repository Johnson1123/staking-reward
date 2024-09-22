import {buildModule} from "@nomicfoundation/hardhat-ignition/modules"

const fundAddress = "";

const BankFunctionModule = buildModule("BankFunctionModule", (m) => {
    const bankfunction = m.contract("BankFunction", [fundAddress]);
    return {bankfunction}
})

export default BankFunctionModule;