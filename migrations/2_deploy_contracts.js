var Token = artifacts.require("Token");
module.exports = function (deployer) {
    deployer.deploy(Token);
    // Additional contracts can be deployed here
};