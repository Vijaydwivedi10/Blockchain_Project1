// Name : Rohan
// Entry Number : 2020CSB1117
const fs = require('fs');
const solc = require('solc');
const Web3 = require('web3');

// Initialize Web3 provider
const web3 = new Web3();

// Function to compile a Solidity contract
function compileContract(sourceFilePath, contractName) {
  // Read the Solidity contract source code
  const contractSourceCode = fs.readFileSync(sourceFilePath, 'utf-8');

  // Compile the contract
  const input = {
    language: 'Solidity',
    sources: {
      [sourceFilePath]: {
        content: contractSourceCode,
      },
    },
    settings: {
      outputSelection: {
        '*': {
          '*': ['*'],
        },
      },
    },
  };

  const compiledContract = JSON.parse(solc.compile(JSON.stringify(input)));

  // Extract ABI and bytecode
  const abi = compiledContract.contracts[sourceFilePath][contractName].abi;
  const bytecode = compiledContract.contracts[sourceFilePath][contractName].evm.bytecode.object;

  return {
    abi,
    bytecode,
  };
}

// Specify the contract name and source file path
const contractName = 'PatientDataManagement';
const sourceFilePath = 'Patient.sol';

// Compile the contract
const contractJSON = compileContract(sourceFilePath, contractName);

// Create JSON file with ABI and bytecode
fs.writeFileSync('Patient.json', JSON.stringify(contractJSON, null, 2));
console.log('Contract ABI and bytecode saved to Patient.json');
