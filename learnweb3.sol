// SPDX-License-Identifier: MIT 
// 以上部分为代码的许可，必不可少，参考：https://spdx.org/licenses/

// 指定使用的版本
pragma solidity 0.8.18;

// 定义一个智能合约
contract Learnweb3 {

    // 定义一个公开的无符号数字类型uint=uint256 该值将保存到区块链上
    uint public uintVal = 1;

    // 定义一个普通字段  
    string public stateStr = '0xdaddd';

    // 使用constant关键词定义一个常量  
    string public constant CONSTANT_STR = '0xdaddd';

    // 使用immutable关键词定义初始化后无法修改的变量  
    // string public immutable IMMUTABLE_STR; //string无法使用immutable
    uint public immutable IMMUTABLE_UINT;
    address public immutable OWN_ADDRESS;


    // 以太坊代币单位 1以太坊 = 10^18 wei
    uint public oneWei = 1 wei;
    uint public oneEther = 1 ether;
    // 1 wei is equal to 1
    bool public isOneWei = 1 wei == 1;
    // 1 ether is equal to 10^18 wei
    bool public isOneEther = 1 ether == 10**18;

    // mapping类型
    mapping(address => uint) public uintValRequestCount;

    // 事件
    event RequestLog(address indexed sender, uint count);

    // 构造函数
    constructor(uint _val){
        IMMUTABLE_UINT = _val;
        OWN_ADDRESS = msg.sender;
    }

    // 修饰方法
    modifier requestAop(){
        // 不存在的用户默认为0
        uint val = uintValRequestCount[msg.sender];
        uintValRequestCount[msg.sender] = ++val;
        _;//默认invoke方法
        // 发送事件
        emit RequestLog(msg.sender, val);
    }


    // 定义一个只读开放接口，由于requestAop有读写，所以不能使用view修饰
    function getUintVal() public requestAop returns (uint){
        return uintVal;
    }

    // 定义一个写开放接口
    function setUintVal(uint _val) public requestAop{
         uintVal = _val;
    }

    // 获取mapping值
    function getUintValRequestCount() public view returns (uint){
        return uintValRequestCount[msg.sender];
    }

    //Pure function declares that no state variable will be changed or read.

    // 定义一个只读开放接口，pure表示只读方法，并且没有依赖任何state变量（不包含常量）
    function getConstantStr() public pure returns (string memory){
        return CONSTANT_STR;
    }

    //View function declares that no state will be changed.

    // 定义一个只读开放接口，依赖state变量必须使用view（不包含常量）
    function getStateStr() public view returns (string memory){
        return stateStr;
    }



    // error
    // 使用assert判断
    function eqAssert(uint x, uint y) public pure {
        assert(x == y);
    }

    // 自定义错误
    error EqError(uint x, uint y);
    // 抛出自定义异常
    function throwError(uint x, uint y) public pure {
        if(x != y){
            revert EqError(x, y);
        }
    }

}
