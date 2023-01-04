const filelink = artifacts.require("filelink");

module.exports = function (deployer) {
  deployer.deploy(filelink);
};
