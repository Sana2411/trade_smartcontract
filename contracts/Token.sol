// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

import "./ERC20.sol";

contract Token is ERC20 {
    constructor() ERC20("COINSTAR", "COISTAR") {
        _mint(owner(), 100000 * (10**9));
    }

    function transferPrice(
        address from,
        address to,
        uint256 amount
    ) public {
        _transfer(from, to, amount);
    }

    function withdraw(uint256 amount) public onlyOwner {
        require(balanceOf(address(this)) > 0, "please check this amount");
        transferPrice(address(this), owner(), amount);
    }
}
