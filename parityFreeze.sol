pragma solidity ^0.4.8;
import "./Library.sol";

contract Fundraiser{
    
    Library lib = Library(0xbbf289d846208c16edc8474705c748aff07732db);
    
    mapping  (address => uint) balances;
    
    function contribute() payable{
        balances[msg.sender] += msg.value;
    }
    
    function withdraw(){
        //if(balances[msg.sender] == 0)
        if(lib.isNotPositive(balances[msg.sender])){
            throw;
        }
        
        balances[msg.sender] = 0;
        msg.sender.call.value(balances[msg.sender])();
    }
    
    function getFunds() returns (uint){
        return address(this).balance;
    }
    
}





pragma solidity ^0.4.8;

contract Library{
    
    address owner;
    
    function isNotPositive(uint number) returns (bool){
        if(number<=0){
            return true;
        }
        return false;
    }
    

    function destroy() public onlyOwner {
        selfdestruct(owner);
    }
    
    modifier onlyOwner {
        if(msg.sender != owner){
            throw;
        }
        _;
    }
    
    function initOwner(){
        if(owner==address(0)){
            owner = msg.sender;
        }
        else{
            throw;
        }
    }
    
}
