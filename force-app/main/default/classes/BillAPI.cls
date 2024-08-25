public with sharing class BillAPI {
    public static void getBills() {
        /* 
        Start by creating an HttpRequest object and set the endpoint and method.
        Endpoint: https://my-json-server.typicode.com/walters954/clicked-intro-development-server/bills
        Method: GET
        Learn more about HTTPRequest: https://developer.salesforce.com/docs/atlas.en-us.apexref.meta/apexref/apex_classes_restful_http_httprequest.htm
        */

        HttpRequest request = new HttpRequest();
        Http http = new Http();
        HttpResponse response;

        try {
            //GET Method
            request.setMethod('GET');
            
            // enpoint
            request.setEndpoint('https://my-json-server.typicode.com/walters954/clicked-intro-development-server/bills');

            // Send the request, get the response
            response = http.send(request);

            // Check the response status
            // Set up an Http object and an HTTPResponse object, then use the .getBody() method to get the response body.
        //https://developer.salesforce.com/docs/atlas.en-us.apexref.meta/apexref/apex_classes_restful_http_httprequest.htm#apex_System_HttpRequest_getBody
            if (response.getStatusCode() == 200) {
                String responseBody = response.getBody();
                System.debug('Response Body: ' + responseBody);
                return responseBody;
            } else {
                return 'Error: ' + response.getStatusCode() + ' - ' + response.getStatus();
            }
        } catch (Exception e) {
            // Handle any exceptions
            return 'Exception: ' + e.getMessage();
        }
    


        


        // Deserialize the JSON response into a list of BillWrapper objects.
        // Learn more about JSON.deserialize: https://developer.salesforce.com/docs/atlas.en-us.apexref.meta/apexref/apex_class_System_Json.htm#apex_System_Json_deserialize

        // Create a list to hold the bills we will insert into Salesforce.

        // Query for active accounts (Active__c = 'Yes').
        // Learn more about SOQL: https://trailhead.salesforce.com/en/content/learn/modules/apex_database/apex_database_soql

        // Create a map to hold active account names and their IDs.
        // Learn more about Maps: https://developer.salesforce.com/docs/atlas.en-us.apexref.meta/apexref/apex_methods_system_map.htm

        // Iterate over the list of active accounts and add their name and ID to the map.


        /*
        Iterate over the list of BillWrapper objects and create a new Bill__c record for each.
        Match the new bill fields with the properties of the BillWrapper class.
        For example, for Bill__c.Balance__c, use Decimal.valueOf(bw.balance.replace('$', '')) to convert the balance to a decimal.
        Remember, DML (Data Manipulation Language) operations should not be inside loops. Learn more about DML: https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_dml_section.htm
        */


        //finally, insert the new bills list
    }

    /*  
    This is a wrapper class. A wrapper class allows us to create an instance of a class with the properties we specify.
    In this case, we are creating a class that will hold the properties for BillId, AccountName, and Balance.
    These properties will be populated from the JSON structure stored in our external data source.
    Once we get the body of our HTTP callout, we will use the following line of code to transform the response body into a list of instances of our wrapper class, BillWrapper:
    List<BillWrapper> bwList = (List<BillWrapper>)JSON.deserialize(responseBody, List<BillWrapper>.class);
    Once we have a list of BillWrapper objects (bwList), we will iterate over the bwList, create a new Bill__c record, and assign the values of the BillWrapper properties to the fields on the Bill__c record.
    */
    public class BillWrapper {
        public String billId;
        public String accountName;
        public String balance;
    }
}
