 // SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;
import "./FirstErc20.sol";

contract Etat {

FirstErc20 public token;
address payable superAdmin;

uint256 counterEnt;
uint256 counterCitizen;
 
//mapping (address => Entreprise) public mapcompany;

mapping (uint => Entreprise) public enterprises;
 
mapping (address => Citizen) public citizens;

mapping (address => mapping(uint256 => bool)) public jobs;

mapping (address => bool) public admins;

mapping (address => uint256) public caisseimpots;

mapping (address => uint256) public balances_citizen;

mapping (address => uint256) public balances_state;

mapping (address => uint256) public caissechomage;

mapping (address => uint256) public caissemaladie;

mapping (address => uint256) public caisseDeces;

mapping (address => uint256) public montantretraite;

constructor(address payable _addr) public{
    superAdmin = _addr;
    admins[_addr] = true;
    address erc20Address;
    token = FirstErc20(erc20Address);
    //admin[msg.sender] = true;
}

/* Variables d'état */
struct Citizen{
     bool isAdmin;
     uint nombreToken;
     string name;
     string symbol;
     uint age;
     bool isIll; 
     bool isWorking;
     uint256 idEnt;    
     bool isBanned; //block.timestamp de la sanction + 520 semaines 
     bool canVote;
     bool isAlive;
     uint registrationDate;
 }
 
 struct Entreprise {
     uint256 id;
     uint256 nombreEmployes;
     uint256 salary_amount;
     bool isValid;
     
 }
 


enum Peines { legere, lourde, grave, tropgrave }


function registerEntreprise(uint256 _employes) public {
 counterEnt++;
 //Enterprise.id = counterEnt;
 enterprises[counterEnt].nombreEmployes = _employes;
 enterprises[counterEnt].salary_amount = enterprises[counterEnt].nombreEmployes*100*10**18;
 
}

function registerCitizen(address _addrcitizen, uint8 _age, bool _isIll) public {
 counterCitizen++;
 citizens[_addrcitizen].isAlive = true;   
 citizens[_addrcitizen].nombreToken = 100;
 citizens[_addrcitizen].age = _age;
 citizens[_addrcitizen].isIll = _isIll;
 citizens[_addrcitizen].registrationDate = block.timestamp;
 if (citizens[_addrcitizen].age >=18 && citizens[_addrcitizen].isIll == false && counterCitizen == counterEnt) {
  jobs[_addrcitizen][counterEnt] = true;
}
}


modifier onlyAdmin (){
        require (admins[msg.sender] == true, "only admin can call this function");
        _;
    }
    

function paymentsalary(address _addrcitizen) public payable {
   // uint time;
    if ((block.timestamp - citizens[_addrcitizen].registrationDate) % 4 weeks == 0 ) 
    balances_citizen[_addrcitizen] +=100*10**18;
}

function votecontrol (address _addrcitizen) public {
    if (citizens[_addrcitizen].nombreToken == 0)
    citizens[_addrcitizen].canVote = false;
    else 
    citizens[_addrcitizen].canVote = true;
}

function paytaxes(address payable _addrcitizen, address payable _addrImpot, address payable _addrAssurance, address payable _addrChomage, address payable _addrRetraite ) public payable {
       
       require (citizens[_addrcitizen].isWorking == true, "only working citizens call this function");
        uint cotisationAssurance  = 100*0.1*10**18;
        uint cotisationImpot = 100*0.1*10**18;
        uint cotisationChomage = 100*0.1*10**18;
        uint cotisationRetraite = 100*0.1*10**18;
        _addrImpot.transfer(cotisationImpot);
        _addrAssurance.transfer(cotisationAssurance);
        _addrChomage.transfer(cotisationChomage);
        _addrRetraite.transfer(cotisationRetraite);
        balances_citizen[_addrcitizen] -= cotisationAssurance + cotisationImpot + cotisationChomage + cotisationRetraite;
        emit Paymentimpot(_addrImpot, cotisationImpot);
        emit PaymentChomage(_addrChomage, cotisationChomage);
        emit PaymentAssurance(_addrAssurance, cotisationAssurance);
        emit PaymentRetraite(_addrImpot, cotisationRetraite);
        
    }
    
 /* function buy(uint256 nbTokens) public payable returns(bool){
       
        require(msg.value >= 0, "ICO: Price is not 0 ether");
        require(nbTokens * _price <= msg.value, "ICO: Not enough Ether for purchase");
        uint256 _realPrice = nbTokens * _price;
        uint256 _remaining = msg.value - _realPrice;
        token.transferFrom(_seller, msg.sender, nbTokens);
        _seller.transfer(_realPrice);
        if(_remaining > 0) {
            msg.sender.transfer(_remaining);
        }
        return true;
    } */    
    

event Paymentimpot(
        address indexed _addrimpots,
        uint256 cotisationImpot
    );
    
event PaymentChomage(
        address indexed _addrChomage,
        uint256 cotisationChomage
    );
    
event PaymentAssurance(
        address indexed _addrAssurance,
        uint256 cotisationAssurance
    );
    
event PaymentRetraite(
        address indexed _addrRetraite,
        uint256 cotisationRetraite
    );
    
}

