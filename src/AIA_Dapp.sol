interface IBlastPoints {
  function configurePointsOperator(address operator) external;
  function configurePointsOperatorOnBehalf(address contractAddress, address operator) external;
}

// EXAMPLE dAPP
contract AIA_Dapp {
  constructor(address _pointsOperator) {
    // be sure to use the appropriate testnet/mainnet BlastPoints address
    IBlastPoints(BlastPointsAddress).configurePointsOperator(_pointsOperator);
  }
}