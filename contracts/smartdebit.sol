contract smartdebit {
    
    struct Account {
        address beneficiary;
        uint fee;
        uint period;
    }
    
    Account[] private accountsToPay;
    
    function createDirectDebit(address account, uint fee, uint period)  {
        // check if the direct debit is not set up for this account
        var acc = new Account();
        acc.beneficiary = account;
        acc.fee = fee;
        acc.period = period;
        
        accountsToPay.add(acc);
    }
    
    function pay() {
        
    }
    
    function getGreeting() constant returns (string g) {
        return greeting;
    }
}