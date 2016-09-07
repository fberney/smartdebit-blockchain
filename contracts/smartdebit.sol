contract smartdebit {
    
    struct Account {
        address beneficiary;
        uint fee;
        uint period;
        bool exists;
    }
    
    mapping (address => Account) private accountsMapping;
    // Mapping from account address to its index in the address array. Used to delete.
    mapping (address => uint) private addressIndices;
    address[] private accountAddresses; // All direct debit account addresses
    
    function createDirectDebit(address beneficiary, uint fee, uint period)  {
        if (accountsMapping[beneficiary].exists == true) {
            throw; // Account already has a direct debit setup against it
        }
        
        var acc = Account(beneficiary, fee, period, true);
        accountsMapping[beneficiary] = acc;
        
        accountAddresses.push(beneficiary);
        addressIndices[beneficiary] = accountAddresses.length+1;
    }
    
    function getDirectDebit(address beneficiary) returns (uint fee, uint period) {
        if (accountsMapping[beneficiary].exists != true) {
            throw;
        }
        
        fee = accountsMapping[beneficiary].fee;
        period = accountsMapping[beneficiary].period;
    }
    
    function getAllDirectDebits() returns (address[] addresses) {
      addresses = accountAddresses;
    }
    
    function deleteDirectDebit(address beneficiary) {
        if (accountsMapping[beneficiary].exists != true) {
            throw;
        }
        
        delete accountsMapping[beneficiary];
        var index = addressIndices[beneficiary]; // Getting index of the beneficiary in the address array
        delete accountAddresses[index];
    }
}