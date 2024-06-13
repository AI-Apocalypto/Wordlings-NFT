// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity 0.8.24;

import "openzeppelin-contracts/contracts/access/extensions/AccessControlDefaultAdminRules.sol";
import "./interfaces/IBlastPoints.sol";
contract AIA_Dapp is AccessControlDefaultAdminRules{
    address public BlastPointsAddress;
  constructor(address _BlastPointsAddress, address _pointsOperator,  uint48 _initialDelay, address _initialDefaultAdmin) AccessControlDefaultAdminRules( _initialDelay, _initialDefaultAdmin){
    BlastPointsAddress = _BlastPointsAddress;
    // be sure to use the appropriate testnet/mainnet BlastPoints address
    IBlastPoints(BlastPointsAddress).configurePointsOperator(_pointsOperator);
  }

  function setBlastPointsAddress(address _BlastPointsAddress) public {
    BlastPointsAddress = _BlastPointsAddress;
  }
}