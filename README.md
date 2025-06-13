# Cloud Code Academy - Integration Developer Program

## Assignment 6: Testing Twilio SMS Integration

This assignment focuses on implementing proper test classes for the Twilio SMS integration you've built, ensuring your integration is robust, reliable, and working as expected.

## 🎯 Learning Objectives

By the end of this lesson, you will be able to:

- Create comprehensive test classes for external API integrations
- Properly mock HTTP callouts in Salesforce
- Implement test data factories for integration testing
- Handle error scenarios and edge cases in your tests
- Validate both outbound and inbound integration functionality

## 📋 Assignment Overview

In this assignment, you will be implementing test classes for your Twilio SMS integration with Salesforce. Your tests will validate both outbound messaging (sending SMS) and inbound messaging (receiving SMS via webhooks), ensuring the integration works reliably and handles errors appropriately.

Your implementation must:

1. Test successful SMS sending via the Twilio API
2. Test SMS message retrieval from Twilio
3. Test webhook endpoints that receive SMS notifications
4. Validate error handling for all integration points
5. Achieve high code coverage (>85%) for your integration classes

## 🔨 Prerequisites

1. Twilio account with API credentials (Account SID and Auth Token)
2. Twilio phone number for sending SMS messages
3. Salesforce Developer org with Twilio integration classes
4. Understanding of HTTP callout mocking in Apex tests

## ✍️ Assignment Tasks

Your tasks for this assignment include:

1. Update the TwilioService class with your actual Twilio credentials
   - Add your Twilio Account SID, Auth Token, and sender phone number
2. Implement the provided `TwilioServiceTest` class for testing SMS sending and retrieval
3. Complete the `TwilioCalloutMock` class for mocking HTTP responses for Twilio API calls
4. Implement the `TwilioRestApiTest` class for testing inbound SMS webhooks
5. Test error handling and edge cases for all integration points

## 🧪 Test Classes to Implement

For this assignment, you need to implement three primary test classes that have been stubbed out for you:

1. **TwilioCalloutMock** - Mock implementation for Twilio API callouts
   - Simulates HTTP responses from Twilio API
   - Handles success and error scenarios
   - Provides functionality for exception testing

2. **TwilioServiceTest** - Tests for outbound SMS functionality
   - Tests successful SMS sending
   - Tests error handling during SMS sending
   - Tests message retrieval functionality
   - Tests edge cases with invalid parameters

3. **TwilioRestApiTest** - Tests for inbound webhook functionality
   - Tests handling of incoming SMS webhooks
   - Tests SMS with media attachments
   - Tests SMS with location data
   - Tests integration with WhatsApp messages

## 🧪 Test Class Structure

For effective testing of integrations, complete the stubbed test classes following this structure:

1. **Setup Data**: Create necessary test data including SMS message records
2. **Configure Mocks**: Set up HTTP callout mocks with appropriate responses
3. **Execute Code**: Call the methods being tested
4. **Verify Results**: Assert that the results match expected outcomes
5. **Test Edge Cases**: Verify behavior with invalid inputs, API errors, etc.

### Example Test Method Implementation

```apex
@isTest
static void testSendSMS() {
    // Setup test data
    String toNumber = '+15551234567';
    String messageBody = 'Test message';
    
    // Configure mock
    Test.setMock(HttpCalloutMock.class, new TwilioCalloutMock(200, 
        '{"sid":"SM123456","status":"sent","body":"Test message"}'));
    
    // Execute code under test
    Test.startTest();
    TwilioResponse response = TwilioService.sendSMS(toNumber, messageBody);
    Test.stopTest();
    
    // Verify results
    System.assertEquals(true, response.success);
    System.assertEquals(200, response.statusCode);
    System.assert(response.body.contains('SM123456'));
}
```

## 📞 Implementing TwilioCalloutMock

The TwilioCalloutMock class is critical for testing Twilio API integration. Your implementation should:

1. Initialize the mock with specific status codes and response bodies
2. Support simulating exceptions in HTTP callouts
3. Return appropriate HTTP responses based on the configuration

```apex
// Example implementation of respond method in TwilioCalloutMock
public HttpResponse respond(HttpRequest request) {
    if (throwException) {
        throw new CalloutException(exceptionMessage);
    }
    
    HttpResponse response = new HttpResponse();
    response.setStatusCode(statusCode);
    response.setBody(responseBody);
    return response;
}
```

## 🔄 Testing Inbound Webhooks with TwilioRestApiTest

For testing webhook endpoints with TwilioRestApiTest:

1. Create mock RestRequest objects that simulate Twilio webhook calls
2. Set appropriate parameters that Twilio would send (From, To, Body, MessageSid, etc.)
3. Set the mock request/response in RestContext
4. Verify proper handling of different webhook scenarios

```apex
// Example of testing an inbound SMS webhook
@isTest
static void testHandleIncomingSMSStandard() {
    // Create test payload
    RestRequest req = new RestRequest();
    req.requestURI = '/services/apexrest/twilio/sms';
    req.httpMethod = 'POST';
    
    // Set parameters as Twilio would send them
    req.addParameter('MessageSid', 'SM123456');
    req.addParameter('From', '+15551234567');
    req.addParameter('To', '+17775553333');
    req.addParameter('Body', 'Test message from Twilio');
    
    RestResponse res = new RestResponse();
    
    // Set current request/response
    RestContext.request = req;
    RestContext.response = res;
    
    // Call webhook method
    Test.startTest();
    TwilioRestApi.handleIncomingSMS();
    Test.stopTest();
    
    // Verify response contains valid TwiML
    String responseBody = res.responseBody.toString();
    Assert.isTrue(responseBody.contains('<Response>'));
    Assert.isTrue(responseBody.contains('<Message>'));
}
```

## 🧩 Integration with Assignment 5

Your tests should also validate the integration with your previous webhook implementation from Assignment 5:

1. Test that webhook events from Assignment 5 can be triggered by Twilio SMS
2. Create test methods that simulate webhook payloads coming from your Assignment 5 implementation
3. Verify that Twilio responses can be properly processed by your webhook handlers

## 🎯 Success Criteria

Your implementation should:

- Pass all test methods with a high success rate
- Achieve at least 85% code coverage for integration classes
- Properly test both success and error scenarios
- Include tests for all stubbed methods in the provided test classes
- Follow best practices for API integration testing

## 💡 Tips

- Remember to update your Twilio API credentials in the TwilioService class
- Use System.debug statements in your tests for troubleshooting
- Create multiple mock scenarios for different API responses
- Test boundary conditions and error cases thoroughly
- Make sure your tests are deterministic and reliable

## 📚 Resources

- [Apex Testing with HTTP Callouts](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_callouts_wsdl2apex_testing.htm)
- [Twilio API Documentation](https://www.twilio.com/docs/sms/api)
- [RestRequest and RestResponse Classes](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_methods_system_restrequest.htm)
- [Test Coverage Best Practices](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_testing_best_practices.htm)

## 🏆 Extra Credit - Optional Challenges

Once you've completed the basic implementation, try these challenges:

1. Implement a test for bulk SMS sending to multiple recipients
2. Add tests for edge cases like international phone numbers
3. Create a test for SMS message delivery status callbacks
4. Implement tests for SMS media attachments (MMS)
5. Integrate with Assignment 5 webhook system

## ❓ Support

If you need help:

- Review the Twilio API documentation
- Check the provided test class stubs for guidance
- Use System.debug to troubleshoot test issues
- Reach out to your instructor

---

Happy coding! 🚀

_This is part of the Cloud Code Academy Integration Developer certification program._

## Copyright

© 2025 Cloud Code. All rights reserved.

This software is provided under the Cloud Code Developer Kickstart Program License (CCDKPL) Version 1.0.
The software is licensed, not sold, and is intended for personal educational purposes only as part of the Cloud Code Developer Kickstart Program.

See the full license terms in LICENSE.md for more details regarding usage restrictions, ownership, warranties, and limitations of liability. 