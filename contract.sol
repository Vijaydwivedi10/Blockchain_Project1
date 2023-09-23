/*
Name -> Vijay Dwivedi
Entry Number -> 2020CSB1140
*/

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title Medical Records Smart Contract
 * @dev A simple smart contract for managing patient medical records.
 */
contract MedicalRecords {
    // Structure to store patient data
    struct Patient {
        string fullName;
        string dob; // Date of Birth
        string contactNumber;
        string medicalHistory;
        address[] authorizedDoctors;
    }

    mapping(address => Patient) public patients;

    event DoctorAccessGranted(address indexed patientAddress, address indexed doctorAddress);
    event DoctorAccessRevoked(address indexed patientAddress, address indexed doctorAddress);

    /**
     * @dev Update or add patient's medical record.
     * @param _fullName The patient's full name.
     * @param _dob The patient's date of birth.
     * @param _contactNumber The patient's contact number.
     * @param _medicalHistory The patient's medical history.
     */
    function updatePatientRecord(string memory _fullName, string memory _dob, string memory _contactNumber, string memory _medicalHistory) public {
        patients[msg.sender].fullName = _fullName;
        patients[msg.sender].dob = _dob;
        patients[msg.sender].contactNumber = _contactNumber;
        patients[msg.sender].medicalHistory = _medicalHistory;
    }

    /**
     * @dev Grant access to a doctor to view the patient's record.
     * @param doctorAddress The Ethereum address of the doctor.
     */
    function grantDoctorAccess(address doctorAddress) public {
        patients[msg.sender].authorizedDoctors.push(doctorAddress);
        emit DoctorAccessGranted(msg.sender, doctorAddress);
    }

    /**
     * @dev Revoke access from a doctor to view the patient's record.
     * @param doctorAddress The Ethereum address of the doctor.
     */
    function revokeDoctorAccess(address doctorAddress) public {
        address[] storage authorizedDoctors = patients[msg.sender].authorizedDoctors;
        for (uint256 i = 0; i < authorizedDoctors.length; i++) {
            if (authorizedDoctors[i] == doctorAddress) {
                authorizedDoctors[i] = authorizedDoctors[authorizedDoctors.length - 1];
                authorizedDoctors.pop();
                emit DoctorAccessRevoked(msg.sender, doctorAddress);
                break;
            }
        }
    }

    /**
     * @dev View the patient's medical history if authorized.
     * @param patientAddress The Ethereum address of the patient.
     * @return The patient's medical history.
     */
    function accessPatientRecord(address patientAddress) public view returns (string memory) {
        Patient storage patient = patients[patientAddress];
        require(patient.authorizedDoctors.length > 0, "No authorized doctors.");
        for (uint256 i = 0; i < patient.authorizedDoctors.length; i++) {
            if (patient.authorizedDoctors[i] == msg.sender) {
                return patient.medicalHistory;
            }
        }
        revert("Doctor not authorized to access patient's record.");
    }
}
