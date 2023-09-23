Setup and Installation:

First, make sure you have Node.js installed on your system. You can download it from Node.js official website.

Install Required Dependencies:

Open your terminal or command prompt and run the following commands to install the necessary Node.js packages:

npm install solc
npm install web3@1

This will install the solc Solidity compiler and the web3 library version 1.


Compile the Smart Contract:

Create a JavaScript file (e.g., code.js) in the same directory as your Patient.sol file.

Generate JSON File:

In your terminal, navigate to the project directory where code.js and Patient.sol are located. Run the following command to generate the JSON file:

This command will compile your Patient.sol contract and create a Patient.json file containing the ABI and bytecode.

Result:

After running the node code.js command, you will have a Patient.json file with the ABI and bytecode of your Solidity smart contract ready for use in your blockchain application.
