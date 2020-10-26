

 contract Voting {

constructor(address payable _addr) public{
    superAdmin = _addr;
    admin[_addr] = true;
    //admin[msg.sender] = true;
}

/* Variables d'état
struct Citizen{
     bool isAdmin;
     uint nombreToken;
     uint age;
     bool isIll; 
     bool isWorking;
     uint256 idEnt;    
     bool isBanned; //block.timestamp de  sanction + 520 semaines 
     bool canVote;
     bool isAlive;
 }
 
 struct Entreprise {
     uint256 id;
     unit256 nombreEmployes ;
     unit256 salary_amount;
     bool isValid;
     
 }
 
uint256 counterEnt;
 
//mapping (address => Entreprise) public mapcompany;

mapping (uint => Entreprise) public enterprises;
 
mapping (address => Citizen) public citizens;

mapping (address => bool) public admins;

mapping (address => uint256) public caisseimpots;

mapping (address => uint256) public balances;

mapping (address => uint256) public caissechomage;

mapping (address => uint256) public caissemaladie;

mapping (address => uint256) public caisseDeces;

mapping (address => uint256) public montantretraite;

enum Peines { legere, lourde, grave, tropgrave };


function registerEntreprise(uint256 _employes) public {
 counterEnt++;
 entreprise[id].nombresEmployes = _employes;
 enterprise[id].salary_amount = nombresEmployes*100*10**18;
 
}

function registerCitizen(address _addrcitizen, unit _age, bool _isIll ) public {
 citizens[_addrcitizen].isAlive = true;   
 citizens[_addrcitizen].nombreToken = 100;
 citizens[_addrcitizen].age = _age;
 citizens[_addrcitizen].isIll = _isIll;
 if (citizens[_addrcitizen].age >=18 && citizens[_addrcitizen].isIll == false) {
  citizens[_addrcitizen].idEnt = ;
 
    
}


modifier onlyAdmin (){
        require (admin[msg.sender] == true, "only admin can call this function");
        _;
    }
    

function paymentsalary(address _addrcitizen) public payable {
    uint time;
    if (block.timestamp + 4 weeks == time) 
    balances[_addrcitizen] +=100*10**18;
}


function pay() public payable {
       
       require (citizens[_addrcitizen].isWorking == true, "only working citizens call this function");
        uint cotisationAssurances  = 100*0.1*10**18;
        uint cotisationImpot = 100*0.1*10**18;
        uint cotisationChomage = 100*0.1*10**18;
        uint cotisationRetraite = 100*0.1*10**18;
        balances[_addrcitizen] -= cotisationAssurances + cotisationImpot + cotisationChomage + cotisationRetraite;
    }
    
    
