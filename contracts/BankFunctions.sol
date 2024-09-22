



// contract Stake {
//  address token;

//  address owner;

//   struct StakeData {
//      uint256 amount;
//      uint256 timestamp;
//      uint8 duration;
//   } 

//   mapping(address => StakeData) private stake;

//   error ZEROSTAKENOTALLOWED();
//   error CANNOTWITHDRAWZERO();
//   error CANNOTWITHDRAWTOZEROADDRESS();
//   error EARLYWITHDRAWNOTALLOW();
//   error INSUFFICIENTTOKEN();
//   error STAKETIMEISLESSTHANONEWEEK();
//   error STAKETIMEISHIGHERTHANONEYEAR();


// constructor(address _token) {
//     owner = msg.sender;
//     token = _token;
// }

// event stakeEvent(address indexed sender, uint256 timestamp, uint256 _amount);
// event withdrawEvent(address indexed sender, uint256 );

//   function stakeToken (uint256 _amount, uint8 _timestamp) external view {

//     if( _amount <= 0){
//         revert ZEROSTAKENOTALLOWED();
//     }
    
//     uint256 _balance = IERC20(token).balanceOf(msg.sender);

//     if(_balance <= _amount){
//         revert INSUFFICIENTTOKEN();
//     }

//     if(_timestamp < 7) {
//         revert STAKETIMEISLESSTHANONEWEEK();
//     }

//     if(_timestamp > 365) {
//         revert STAKETIMEISHIGHERTHANONEYEAR();
//     }


//     StakeData memory userStake = stake[msg.sender];


//     userStake.amount += _amount;

//     userStake.timestamp = block.timestamp + (86400 * _timestamp);

//     userStake.duration = _timestamp;

//   } 


// function withdraw( uint256 _amount ) external {
//     if(_amount <= 0){
//         revert CANNOTWITHDRAWZERO();
//     }
//     if(msg.sender == address(0)){
//         revert CANNOTWITHDRAWTOZEROADDRESS();
//     }

//     StakeData memory userStake = stake[msg.sender];

//     if(block.timestamp > userStake.timestamp){
//         revert EARLYWITHDRAWNOTALLOW();
//     }

//     if(_amount > userStake.amount){
//         revert INSUFFICIENTTOKEN();
//     }

//     userStake.amount -= _amount;

//     IERC20(token).transfer(msg.sender, _amount);

//     emit withdrawEvent(msg.sender, _amount);
// }

// function transfer(address to, uint256 _amount) external{
//     if(_amount <= 0){
//         revert CANNOTWITHDRAWZERO();
//     }
//     if(to == address(0)){
//         revert CANNOTWITHDRAWTOZEROADDRESS();
//     }

//     StakeData memory userStake = stake[msg.sender];

//     if(block.timestamp > userStake.timestamp){
//         revert EARLYWITHDRAWNOTALLOW();
//     }

//     if(_amount > userStake.amount){
//         revert INSUFFICIENTTOKEN();
//     }

//     userStake.amount -= _amount;

//     IERC20(token).transfer(msg.sender, _amount);

//     emit withdrawEvent(to, _amount);

// }

// function getStakeBalance() external view returns(uint256){
//     StakeData memory userStake = stake[msg.sender];
//     return userStake.amount;
// }

// function remainningTime() external view returns(uint256){
//     StakeData memory userStake = stake[msg.sender];
//     return userStake.timestamp;
// }

// function stakeDuration() external view returns(uint256){
//     StakeData memory userStake = stake[msg.sender];
//     return userStake.duration;
// }
// }


// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
contract BankFunction{ 

    address owner;
    address fundAddress;
    mapping(address => uint256)balances;

    error NOTOWNER();
    error ADDRESSZERODETECTED();
    error CANTSENDTOADDRESSZERO();
    error INSUFFICIENTFUND();
    error CANTSENDZEROFUND();
    error CANTSAVEZEROFUND();
    error CANTWITHDRAWZEROFUND();

    constructor(address _fundAddress){
        owner = msg.sender;

        fundAddress = _fundAddress;
    }

    function deposit(uint256 _amount) external{

        if(msg.sender == address(0)){
            revert ADDRESSZERODETECTED();
        }

        if(_amount <= 0){
            revert CANTSAVEZEROFUND();
        }

        uint256 userBalance = IERC20(fundAddress).balanceOf(msg.sender);

        if(userBalance < _amount){
            revert INSUFFICIENTFUND();
        }
        
        IERC20(fundAddress).transferFrom(msg.sender, address(this), _amount);

        balances[msg.sender] += _amount;
    }

    function ownerWithdraw(uint256 _amount) external{

        if(msg.sender == address(0)){
            revert ADDRESSZERODETECTED();
        }

        if(_amount <= 0){
            revert CANTWITHDRAWZEROFUND();
        }

        notOwner();

        uint256 contractBalance = IERC20(fundAddress).balanceOf(address(this));

        if(contractBalance < _amount){
            revert INSUFFICIENTFUND();
        }

        IERC20(fundAddress).transfer(msg.sender, _amount);
    }
    function withdraw(uint256 _amount) external{
        if(msg.sender == address(0)){
            revert ADDRESSZERODETECTED();
        }

        if(_amount <= 0){
            revert CANTWITHDRAWZEROFUND();
        }

        uint256 userBalance = balances[msg.sender];

        if(userBalance < _amount){
            revert INSUFFICIENTFUND();
        }

        balances[msg.sender] -= _amount;

        IERC20(fundAddress).transfer(msg.sender, _amount);
    }

    function transfer(address _to, uint32 _amount) external {

        if(msg.sender == address(0)){
            revert ADDRESSZERODETECTED();
        }
        if(_to == address(0)){
            revert CANTSENDTOADDRESSZERO();
        }

        if(_amount <= 0){
            revert CANTSENDZEROFUND();
        }

        uint256 userBalance = balances[msg.sender];

        if(userBalance < _amount){
            revert INSUFFICIENTFUND();
        }
        
        balances[msg.sender] -= _amount;

        IERC20(fundAddress).transferFrom(address(this), _to, _amount);

    }

    function checkBalance() external view returns(uint256){
        uint256  balance = balances[msg.sender];
        return balance;
    }

    function checkOtherUserBalance() external view returns(uint256){
        notOwner();

        uint256 balance = balances[msg.sender];

        return balance;
    }

    function checkBankBalance() external view returns(uint256){
         notOwner();

        uint256 balance = IERC20(fundAddress).balanceOf(address(this));

        return balance;
    }

    function depositForOtherWithin(address _user, uint160 _amount) external {
        if(msg.sender == address(0)){
            revert ADDRESSZERODETECTED();
        }
        if(_user == address(0)){
            revert CANTSENDTOADDRESSZERO();
        }

        if(_amount <= 0){
            revert CANTSENDZEROFUND();
        }

        uint256 userBalance = balances[msg.sender];

        if(userBalance < _amount){
            revert INSUFFICIENTFUND();
        }
        
        balances[msg.sender] -= _amount;
        balances[_user] += _amount;
        
    }

    function depositNotWithin(address _user, uint160 _amount) external {
    if(msg.sender == address(0)){
            revert ADDRESSZERODETECTED();
        }
        if(_user == address(0)){
            revert CANTSENDTOADDRESSZERO();
        }

        if(_amount <= 0){
            revert CANTSENDZEROFUND();
        }

        uint256 userBalance = IERC20(fundAddress).balanceOf(msg.sender);

        if(userBalance < _amount){
            revert INSUFFICIENTFUND();
        }
        
        IERC20(fundAddress).transferFrom(msg.sender, address(this), _amount);

        balances[_user] += _amount;
    }

    function notOwner() private view{
        if(msg.sender != owner){
            revert NOTOWNER();
        }

    }


}