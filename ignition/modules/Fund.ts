
import {buildModule} from "@nomicfoundation/hardhat-ignition/dist/src/modules"

const FUNDModule = buildModule("FUNDModule", (m) => {

  const fund = m.contract("FUND");

  return { fund };
});

export default FUNDModule;