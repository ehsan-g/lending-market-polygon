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
                0, //interest
                address(0), //collateral addresss
                0, // collatral amount
                0, // collatral Eth price
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

    function requestNewLoan(
        uint256 _loanAmount,
        uint128 duration,
        uint256 _interest,
        address _collateralAddress,
        uint256 _collateralAmount,
        uint256 _collateralPriceInETH
    ) public returns (address _loanContract) {
        _loanContractAddress = address(
            new LoanContract(
                _loanAmount,
                _duration,
                "", //meta data
                _interest,
                _collateralAddress,
                _collateralAmount,
                _collateralPriceInETH,
                50,
                msg.sender,
                address(0),
                LoanContract.LoanStatus.REQUEST
            )
        );

        loans.push(_loanContractAddress);

        emit LoanRequestCreated(msg.sender, _loanContractAddress);

        return _loanContractAddress;
    }
}
