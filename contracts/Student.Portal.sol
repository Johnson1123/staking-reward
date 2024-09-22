// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract StudentPortal{
    address owner;

    struct STUDENTSTRUCT{
        address id;
        string name;
        string email;
        string dob;
        string lga;
        string state;
        string country;
        uint8 level;
        string grade;
        uint8 matricNum;
    }

    mapping(address => STUDENTSTRUCT) public students;

    error NOTOWNER();
    error STUDENTNOTEXIST();
    error STUDENTALREADYEXIST();
    error CANTSAVESTUDENTWITHZEROADDRESS();

    event CREATESTUDENT(address indexed id,string indexed name, uint8 indexed matricNum);
    event UPDATESTUDENT(address indexed id, string indexed name,uint8 indexed matricNum);

    event DELETESTUDENT(address indexed id,string indexed name, uint8 indexed matricNum);

    constructor() {
        owner = msg.sender;
    }
    
    function createStudent(STUDENTSTRUCT memory _student) external{

        notOwner();

        if(_student.id == address(0)){
            revert CANTSAVESTUDENTWITHZEROADDRESS();
        }

        STUDENTSTRUCT memory student = students[_student.id];

        if(student.id != address(0)){
            revert STUDENTALREADYEXIST();
        }

        students[_student.id].id = _student.id;

        students[_student.id].name = _student.name;

        students[_student.id].email = _student.email;

        students[_student.id].matricNum = _student.matricNum;

        students[_student.id].grade = _student.grade;

        students[_student.id].level = _student.level;

        students[_student.id].country = _student.country;

        students[_student.id].lga = _student.lga;

        students[_student.id].state = _student.state;

        students[_student.id].dob = _student.dob;     

         emit CREATESTUDENT(students[_student.id].id,students[_student.id].name,students[_student.id].matricNum);

    }

    function updateStudent(STUDENTSTRUCT memory _student) external {
        notOwner();
        
        if(students[_student.id].id == address(0)){
            revert STUDENTNOTEXIST();
        }

        students[_student.id].id = _student.id;
        students[_student.id].name = _student.name;
        students[_student.id].email = _student.email;
        students[_student.id].matricNum = _student.matricNum;
        students[_student.id].grade = _student.grade;
        students[_student.id].level = _student.level;
        students[_student.id].country = _student.country;
        students[_student.id].lga = _student.lga;
        students[_student.id].state = _student.state;
        students[_student.id].dob = _student.dob;     

        emit UPDATESTUDENT(students[_student.id].id,students[_student.id].name,students[_student.id].matricNum);
    }

    function deleteStundent(address _student) external {
        notOwner();

        STUDENTSTRUCT memory student = students[_student];

        if(student.id == address(0)){
            revert STUDENTNOTEXIST();
        }

        delete students[_student];

        emit DELETESTUDENT(student.id, student.name, student.matricNum);
    }

    function retriveStudent(address _student) external view returns(STUDENTSTRUCT memory){
         notOwner();
        
        if(students[_student].id == address(0)){
            revert STUDENTNOTEXIST();
        }

        STUDENTSTRUCT memory student = students[_student];

        return student;


    }

    function notOwner () private view {
        if(msg.sender != owner){
            revert NOTOWNER();
        }
    }


}