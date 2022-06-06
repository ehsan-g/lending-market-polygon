//SPDX-License-Identifier: Unlicense
pragma solidity 0.8.9;

import "openzeppelin-solidity/contracts/ownership/Ownable.sol";
import "openzeppelin-solidity/contracts/lifecycle/Pausable.sol";
import "./LoanContract.sol";

contract LoanCreator is Ownable, Pausable {
    address[] public loans;

    constructor() public {}

    event LoanCreated(address, address);

    function createNewLoanOffer(
        uint256 _loanAmount,
        uint128 _duration,
        string memory loanMeta
    ) public returns (address _loanContract) {
        _loanContract = address(
            new LoanContract(
                _loanAmount,
                duration,
                loanMeta,
                0,
                address(0),
                0,
                0,
                0,
                address(0),
                msg.sender,
                LoanContract.LoanStatus.OFFER
            )
        );

        loans.push(_loanContract);
        emit LoanCreated(msh.sender, _loanContract);

        return _loanContractAddress;
    }
}
