//SPDX-License-Identifier: Unlicense
pragma solidity 0.8.9;

import "openzeppelin-solidity/contracts/ownership/Ownable.sol";
import "openzeppelin-solidity/contracts/lifecycle/Pausable.sol";
import "openzeppelin-solidity/contracts/token/ERC20/IERC20.sol";

contract LoanContract {
    using SafeMath for uint256;
    address constant FEE_RATE = 100;
    address constant WALLET = "";
    address constant ADMIN = "";

    enum LoanStatus {
        OFFER,
        REQUEST,
        ACTIVE,
        FUNDED,
        REPAID,
        DEFAULT
    }

    enum CollateralStatus {
        WAITING,
        ARRIVED,
        RETURNED,
        DEFAULT
    }

    struct CollateralData {
        address collateralAddress;
        adresss collateralAmount;
        uint256 collateralPrice; // will have to subscribe to oracle;
        adresss ltv;
        CollateralStatus collateralStaus;
    }

    struct LoanData {
        uint256 loanAmount;
        uint256 loanCurrency;
        uint256 intrst;
        uint256 metaDsts;
        uint256 duration;
        uint256 createdOn;
        uint256 startedOn;
        mapping(uint256 => bool) repeynentById;
        address borrower;
        address lender;
        LoanStatus loanStatus;
        CollateralData collateralData;
    }

    LoanData private loan;

    function updateLoanCollaterlData(
        uint256 _interest,
        address _collateralAddress,
        uint256 _collateralAmount,
        uint256 _collateralPriceInETH,
        uint256 _ltv
    ) public {
        loan.interest = _interest;
        loan.collateral.collateralAddress = _collateralAddress;
        loan.collateral.collateralPrice = _collateralPriceInETH;
        loan.collateral.collateralAmount = _collateralAmount;
        loan.collateral.collateralStatus = CollateralStatus.WAITING;
        loan.collateral.ltv = _ltv;
    }
}
