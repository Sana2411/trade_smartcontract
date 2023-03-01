// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;
import "./Token.sol";

contract coinstar is Ownable {
    // uint256 public minAmount;

    uint256 public tokenPrice = 0.0000000000000001 ether;
    Token public MyToken;

    mapping(address => uint256) balances;
    uint256 public sellPrice;
    uint256 public buyPrice;

    mapping(address => uint256[]) InvestorAddress;
    mapping(uint256 => uint256) public investorAmount;
    uint256 public InvestorId;

    function initialize(Token _myToken) public onlyOwner {
        MyToken = Token(_myToken);
    }

    address public seller;
    uint256 public price;

    event Purchase(address indexed buyer, uint256 price);

    function getID(address user) public view returns (uint256[] memory) {
        return InvestorAddress[user];
    }

    function getRate() public view returns (uint256) {
        return tokenPrice;
    }

    function setPrices(uint256 newSellPrice, uint256 newBuyPrice)
        public
        onlyOwner
    {
        sellPrice = newSellPrice;
        buyPrice = newBuyPrice;
    }

    function buy(uint256 token) public payable {
        // require(msg.value >= token, "insufficient funds");
        InvestorId++;
        InvestorAddress[msg.sender].push(InvestorId);
        balances[msg.sender] += token;
        MyToken.transferPrice(owner(), msg.sender, token);
        investorAmount[InvestorId] = (token * 1);
        tokenPrice = tokenPrice + (token * 1);
    }

    function sell(uint256 amount, uint256 id) public {
        require(investorAmount[id] >= 1, "No token left in user wallet");
        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(
            amount * (tokenPrice - investorAmount[id])
        );
        MyToken.transferPrice(msg.sender, owner(), amount);
        investorAmount[id] -= amount;
        tokenPrice = tokenPrice - (amount * (1));
    }
}
