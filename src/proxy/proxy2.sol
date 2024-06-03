// //SPDX-Licens-Identifer: MIT
// pragma solidity ^0.8.19;
// import "@openzeppelin/contracts/proxy/transparent/ProxyAdmin.sol";
// import "@openzeppelin/contracts/proxy/transparent/TransparentUpgradeableProxy.sol";

// contract HelloWorldProxydeployer {

//     address public admin;
//     address public proxy;
//     constructor(address _implementacen){
//         proxyAdmin admininstance = new ProxyAdmin(msg.sender);
//         admin = address(adminInstance);
//         TransparetUpgradeableProxy procyInstance = new transparentUpgrabealeProxy(_implementation, admin, "");
//         proxy = address(proxyInstance);
//     }
// }