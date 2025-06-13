/**
 * Anonymous Apex script to test Twilio integration
 * Run this script in the Developer Console or VS Code to test your Twilio integration
 */

// Test sending an SMS
String testPhoneNumber = '+18777804236'; // Replace with your test phone number
String testMessage = 'Test message from Salesforce ' + Datetime.now();

System.debug('Sending SMS to: ' + testPhoneNumber);
System.debug('Message: ' + testMessage);

// Send the SMS using the Twilio service
TwilioResponse response = TwilioService.sendSMS(testPhoneNumber, testMessage);

// Print response details
System.debug('Response success: ' + response.success);
System.debug('Response status code: ' + response.statusCode);
System.debug('Response body: ' + response.getBodyAsJson());

// If there was an error, print the error message
if (!response.success) {
    System.debug('Error message: ' + response.getErrorMessage());
}

// Test retrieving messages
System.debug('Retrieving messages...');
TwilioResponse messagesResponse = TwilioService.getMessages(5);
System.debug('Messages Response success: ' + messagesResponse.success);
System.debug('Messages Response status code: ' + messagesResponse.statusCode);
System.debug('Messages Response body: ' + messagesResponse.getBodyAsJson()); 