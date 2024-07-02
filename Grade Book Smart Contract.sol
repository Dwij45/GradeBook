// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.2;
contract GradeBook{

 address public owner;
struct Grade{
    string name;
    string [] Subject;
    uint [] grades;
}
mapping(string => uint[]) public studentGrades;
Grade public strudent1;

constructor() {
        owner = msg.sender;
    }

    // Modifier to restrict access to the owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Not the contract owner");
        _;
    }
    // Function to add a grade for a student
        function addGrade(string memory _subject, uint _grade) public {
        studentGrades[_subject].push(_grade);  // Add grade to the array of grades for the specific subject
    }
         // Update grade at specific index in array
    function updateGrade(string memory _subject, uint _index, uint _newGrade) public onlyOwner{
        require(_index < studentGrades[_subject].length, "Index out of bounds");
        studentGrades[_subject][_index] = _newGrade; 
    }
        // Return all grades for the subject
 function getGrade(string memory _subject) public view returns (uint[] memory){
        return studentGrades[_subject];  
    }


    // Function to calculate the average grade for a student
    function getAverageGrade(string memory _subject) public view returns (uint) {
        uint total = 0;
        uint count = studentGrades[_subject].length;

        // Check if the student exists and has grades
        require(count > 0, "Student has no grades");

        for (uint i = 0; i < count; i++) {
        total += studentGrades[_subject][i];  // Corrected line
    }

        return total / count;
    }
}
