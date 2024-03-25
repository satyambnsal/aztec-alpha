pragma solidity >=0.8.18;

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {SafeERC20} from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

contract TokenPortal {
  using SafeERC20 for IERC20;


  function initialize(address _registry, address _underlying, bytes32 _l2Bridge) external {
  }

  function depositToAztecPublic() {}


  function depositToAztecPrivate() {}
 
  function withdraw() {}

}