 // SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;
import "./FirstErc20.sol";

contract Etat {

FirstErc20 public token;
address superAdmin;

uint256 counterEnt;
uint256 counterCitizen;
uint256 counterTime;
address payable _addrImpots;
address payable _addrChomage;
address payable _addrAssurance;
address payable _addrRetraite;

 
//mapping (address => Entreprise) public mapcompany;

mapping (uint => Entreprise) public enterprises;
 
mapping (address => Citizen) public citizens;

mapping (address => Admin) public admins;

mapping (address => mapping(uint256 => bool)) public jobs;

//mapping (address => bool) public listadmins;

mapping (address => uint256) public caisseImpots;

mapping (address => uint256) public balances_citizen;

mapping (address => uint256) public balances_state;

mapping (address => uint256) public balances_admin;

mapping (address => uint256) public caisseChomage;

mapping (address => uint256) public caisseAssurance;

mapping (address => uint256) public caisseDeces;

mapping (address => uint256) public caisseRetraite;



/* Variables d'état */
struct Citizen{
     bool isAdmin;
     uint nombreToken;
     string name;
     string symbol;
     uint age;
     uint timestamp_age;
     bool isIll; 
     bool isWorking;
    // uint256 idEnt;    
     bool isBanned; //block.timestamp de la sanction + 520 semaines 
     bool isAlive;
     uint conges_maladie;
     uint registrationDate;
     uint no_punishments;
     uint duree_puni;
     bool isRetired;
     
 }
 
 struct Entreprise {
     uint256 id;
     uint256 nombreEmployes;
     uint256 salary_amount;
     bool isValid;
     }
 

struct Admin {
    uint duration; // block.timestamp de l'election + 8 semaines
    bool mauvaise_gestion; 
    uint duree_puni;
    
}

constructor(address payable addrImpots, address payable addrChomage, address payable addrAssurance, address payable addrRtetraite) public {
    superAdmin = address(this);
   // admins[_addr] = true;
    address erc20Address;
    _addrImpots = addrImpots;
    _addrChomage = addrChomage;
    _addrAssurance = addrAssurance;
    _addrRetraite = addrRtetraite;
    token = FirstErc20(erc20Address);
}

enum Peines { legere, lourde, grave, tropgrave }


function registerEntreprise(uint256 _employes) public onlyAdmin {
 counterEnt++;
 //Enterprise.id = counterEnt;
 //enterprises[counterEnt].nombreEmployes = _employes;
 enterprises[counterEnt].salary_amount = enterprises[counterEnt].nombreEmployes*100*10**18;
 enterprises[counterEnt].isValid = true;
 
}

function registerCitizen(address _addrcitizen, uint8 _age, bool _isIll) public onlySuperAdmin {
 counterCitizen++;
 citizens[_addrcitizen].isAlive = true;   
 citizens[_addrcitizen].nombreToken = 100;
 citizens[_addrcitizen].age = _age;
 citizens[_addrcitizen].isIll = _isIll;
 citizens[_addrcitizen].registrationDate = block.timestamp;
 citizens[_addrcitizen] = Citizen(false, 100, token.name(), token.symbol(), _age, _age*52 weeks, false, false, false, true, 0, block.timestamp, 0, 0, false );
 if (citizens[_addrcitizen].age >=18 && citizens[_addrcitizen].isIll == false && counterCitizen == counterEnt) {
  jobs[_addrcitizen][counterEnt] = true;
  enterprises[counterEnt].nombreEmployes++;
}
}


modifier onlyAdmin (){
        require (citizens[msg.sender].isAdmin == true, "only admin can call this function");
        _;
    }

modifier onlySuperAdmin (){
        require (msg.sender == superAdmin, "only superAdmin can call this function");
        _;
    }




function adminelection(address _addrcitizen) public payable {
    citizens[_addrcitizen].isAdmin == true;
    admins[_addrcitizen].duration == block.timestamp + 8 weeks;
    balances_admin[_addrcitizen] -=100*10**18;
}


function citizen_punished(address _addrcitizen) public onlySuperAdmin {
    require (admins[_addrcitizen].duration > block.timestamp, "not a valid admin any more");
    if (citizens[_addrcitizen].no_punishments == 1) 
         balances_citizen[_addrcitizen] -=5*10**18;
    if (citizens[_addrcitizen].no_punishments == 2) 
            balances_citizen[_addrcitizen] -=50*10**18;
    if (citizens[_addrcitizen].no_punishments == 3) 
            balances_citizen[_addrcitizen] -=100*10**18;
     if (citizens[_addrcitizen].no_punishments == 4) {
            citizens[_addrcitizen].duree_puni = block.timestamp + 520 weeks;
            _addrImpots.transfer(balances_citizen[_addrcitizen]);
     }
    if (admins[_addrcitizen].mauvaise_gestion == true) {
        admins[_addrcitizen].duree_puni = block.timestamp + 520 weeks; 
        _addrImpots.transfer(balances_admin[_addrcitizen]);
    }
}



function paymentsalary(address _addrcitizen) public onlyAdmin {
    require ((block.timestamp - citizens[_addrcitizen].registrationDate % 4 weeks) == 0, "Payment is carried out every 4 weeks after the registration"); 
    balances_citizen[_addrcitizen] +=100*10**18;
}

function votecontrol (address _addrcitizen) public returns (bool) {
    if (citizens[_addrcitizen].nombreToken == 0)
    return false;
    else 
    return true;
}

 function receive_fromChomage(address payable _addrcitizen, uint256 _allocation) public onlyAdmin {
     require(citizens[_addrcitizen].isWorking == false, "Only unemployed citizens can be payed from this caisse");
     _addrcitizen.transfer(_allocation);
 }
 
 function illness(address _addrcitizen, uint256 recovery_time) public onlyAdmin {
     citizens[_addrcitizen].conges_maladie = block.timestamp + recovery_time;
     citizens[_addrcitizen].isIll == true;
 }
 
 function receive_fromAssurance(address payable _addrcitizen, uint256 _assurance) public onlyAdmin {
      require(citizens[_addrcitizen].isIll == true, "Only ill citizens can be payed from this caisse");
     _addrcitizen.transfer(_assurance);
 }
 
 function consulter_fromimpots(address _addrcitizen) public view onlyAdmin returns (uint256){
      return caisseImpots[_addrImpots];
 }
 
function retirement(address _addrcitizen, uint timestamp_age) public onlyAdmin {
    if (block.timestamp - citizens[_addrcitizen].registrationDate + citizens[_addrcitizen].timestamp_age == 3120 weeks) {
        citizens[_addrcitizen].isRetired = true;
    }
}

function receive_retraite(address payable _addrcitizen) public {
    require(citizens[_addrcitizen].isRetired == true, 'Only retired citizens can receive retire');
    _addrcitizen.transfer(caisseRetraite[_addrcitizen]);
}

function paytaxes(address payable _addrcitizen) public payable {
       
       require (citizens[_addrcitizen].isWorking == true, "only working citizens call this function");
        uint cotisationAssurance  = 10*10**18;
        uint cotisationImpot = 10*10**18;
        uint cotisationChomage = 10*10**18;
        uint cotisationRetraite = 10*10**18;
        _addrImpots.transfer(cotisationImpot);
        _addrAssurance.transfer(cotisationAssurance);
        _addrChomage.transfer(cotisationChomage);
        _addrRetraite.transfer(cotisationRetraite);
        balances_citizen[_addrcitizen] -= cotisationAssurance + cotisationImpot + cotisationChomage + cotisationRetraite;
        caisseImpots[_addrImpots] +=cotisationImpot;
        caisseAssurance[_addrcitizen] +=cotisationAssurance;
        caisseChomage[_addrcitizen] +=cotisationChomage;
        caisseRetraite[_addrcitizen] +=cotisationRetraite;
      /*  emit Paymentimpot(_addrImpot, cotisationImpot);
        emit PaymentChomage(_addrChomage, cotisationChomage);
        emit PaymentAssurance(_addrAssurance, cotisationAssurance);
        emit PaymentRetraite(_addrImpot, cotisationRetraite); */
    }
    
function deces(address _addrcitizen) public onlyAdmin{
    citizens[_addrcitizen].isAlive == false;
    _addrImpots.transfer(balances_citizen[_addrcitizen]);
    _addrImpots.transfer(caisseImpots[_addrcitizen]);
    _addrImpots.transfer(caisseAssurance[_addrcitizen]);
    _addrImpots.transfer(caisseChomage[_addrcitizen]);
    _addrImpots.transfer(caisseImpots[_addrcitizen]);
}

/*event Paymentimpot(
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
    ); */
    
}


