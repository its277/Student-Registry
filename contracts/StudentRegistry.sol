// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract StudentRegistry {
    address public owner;

    struct Student {
        string name;
        uint256 regNo;
        string dob;
        string className;
    }

    mapping(uint256 => Student) private students;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can perform this action.");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    // to add a new student
    function addStudent(
        uint256 _regNo, 
        string memory _name, 
        string memory _dob, 
        string memory _className
    ) public onlyOwner {
        Student memory newStudent = Student({
            name: _name,
            regNo: _regNo,
            dob: _dob,
            className: _className
        });
        students[_regNo] = newStudent;
    }

    // this is used edit student data
    function editStudent(
        uint256 _regNo, 
        string memory _name, 
        string memory _dob, 
        string memory _className
    ) public onlyOwner {
        require(bytes(students[_regNo].name).length != 0, "Student not found.");

        students[_regNo].name = _name;
        students[_regNo].dob = _dob;
        students[_regNo].className = _className;
    }

    // this is used to view student information
    function viewStudent(uint256 _regNo) public view returns (string memory, string memory, string memory) {
        require(bytes(students[_regNo].name).length != 0, "Student not found.");

        Student memory student = students[_regNo];
        return (student.name, student.dob, student.className);
    }

    // deleting a student data
    function deleteStudent(uint256 _regNo) public onlyOwner {
        require(bytes(students[_regNo].name).length != 0, "Student not found.");

        delete students[_regNo];
    }

    // checking if a student is registered or not
    function isRegistered(uint256 _regNo) public view returns (bool) {
        return bytes(students[_regNo].name).length != 0;
    }

}
