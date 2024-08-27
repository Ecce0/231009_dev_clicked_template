trigger billTrigger on Bill__c (before insert, after insert) {
    if (Trigger.isBefore) {
    for (Bill__c bill : Trigger.new) {
    if (bill.Account__c == '' || bill.Account__c == null) {
    bill.Account__c.addError('The Account number is required');
    }
    if (bill.Invoice_Number__c == null || bill.Invoice_Number__c.length() == 0) {
    bill.Invoice_Number__c = UUID.randomUUID().toString().substring(0, 25);
    }
    }
    }
    if (Trigger.isAfter) {
    List<Opportunity> opportunitiesToCreate = new List<Opportunity>();
    for (Bill__c bill : Trigger.new) {
    if (bill.Account__c != null) {
    List<Opportunity> openOpportunities = [SELECT Id FROM Opportunity WHERE AccountId = :bill.Account__c AND IsClosed = false LIMIT 1];
    if (openOpportunities.isEmpty()) {
    Opportunity opp = new Opportunity();
    opp.AccountId = bill.Account__c;
    opp.Amount = bill.Balance__c; // Assuming Balance__c is a field on the Bill__c object
    opp.StageName = 'Prospecting'; // Default stage for a new Opportunity
    opp.CloseDate = Date.today().addMonths(1); // Set a default Close Date
    opp.Name = bill.Account__r.Name + ' - Opportunity ' + bill.Invoice_Number__c; // Assuming Invoice_Number__c is a field on Bill__c
    opportunitiesToCreate.add(opp);
    }
    }
    }
    if (!opportunitiesToCreate.isEmpty()) {
    insert opportunitiesToCreate;
    }
    }
    }