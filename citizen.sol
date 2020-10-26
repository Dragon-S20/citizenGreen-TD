  // SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;
import "./FirstErc20.sol";

contract Etat {

FirstErc20 public token;
constructor(address payable _addr) public{
    superAdmin = _addr;
    admin[_addr] = true;
    address erc20Address;
    token = FirstErc20(erc20Address);
    //admin[msg.sender] = true;
}

/* Variables d'état */
struct Citizen{
     bool isAdmin;
     uint nombreToken;
     string name = token._name;
     string symbol = token._symbol;
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
 
uint256 counterEnt;
uint256 counterCitizen;
 
//mapping (address => Entreprise) public mapcompany;

mapping (uint => Entreprise) public enterprises;
 
mapping (address => Citizen) public citizens;

mapping (address => mapping(uint256 => bool)) public jobs;

mapping (address => bool) public admins;

mapping (address => uint256) public caisseimpots;

mapping (address => uint256) public balances_citizen;

mapping (address => uint256) public caissechomage;

mapping (address => uint256) public caissemaladie;

mapping (address => uint256) public caisseDeces;

mapping (address => uint256) public montantretraite;

enum Peines { legere, lourde, grave, tropgrave }


function registerEntreprise(uint256 _employes) public {
 counterEnt++;
 entreprise[id].nombresEmployes = _employes;
 enterprise[id].salary_amount = nombresEmployes*100*10**18;
 
}

function registerCitizen(address _addrcitizen, unit _age, bool _isIll ) public {
 counterCitizen++;
 citizens[_addrcitizen].isAlive = true;   
 citizens[_addrcitizen].nombreToken = 100;
 citizens[_addrcitizen].age = _age;
 citizens[_addrcitizen].isIll = _isIll;
 citizens[_addrcitizen].registrationDate = block.timestamp;
 if (citizens[_addrcitizen].age >=18 && citizens[_addrcitizen].isIll == false && counterCitizen == CounterEnt) {
  jobs[_addrcitizen][CounterEnt] = true;
}
}


modifier onlyAdmin (){
        require (admin[msg.sender] == true, "only admin can call this function");
        _;
    }
    

function paymentsalary(address _addrcitizen) public payable {
   // uint time;
    if ((block.timestamp - citizens[_addrcitizen].registrationDate) % 4 weeks == 0 ) 
    balances[_addrcitizen] +=100*10**18;
}

function votecontrol (address _addrcitizen) public {
    if (citizens[_addrcitizen].nombreToken == 0)
    citizens[_addrcitizen].canVote = false;
    else 
    citizens[_addrcitizen].canVote = true;
}

function pay() public payable {
       
       require (citizens[_addrcitizen].isWorking == true, "only working citizens call this function");
        uint cotisationAssurances  = 100*0.1*10**18;
        uint cotisationImpot = 100*0.1*10**18;
        uint cotisationChomage = 100*0.1*10**18;
        uint cotisationRetraite = 100*0.1*10**18;
        balances[_addrcitizen] -= cotisationAssurances + cotisationImpot + cotisationChomage + cotisationRetraite;
    }
    
    
