/**
 * TwilioServiceTest - Test class for TwilioService
 * @see TwilioService
 * 
 * TODO: Implement test methods to verify the functionality of the TwilioService class
 */
@IsTest
private class TwilioServiceTest {
    
    /**
     * Test the sendSMS method with a valid request
     * 
     * TODO: Implement this test method to verify that sending an SMS works correctly
     */
    @IsTest
    static void testSendSMS() {
        // TODO: Setup test data
        // - Create test phone number and message body
        
        // TODO: Setup mock callout response
        // - Use TwilioCalloutMock to simulate a successful response
        
        // TODO: Execute the test
        // - Call TwilioService.sendSMS() method
        
        // TODO: Verify results
        // - Verify that response is successful
        // - Verify status code is correct
        // - Verify response body contains expected values (sid, status, etc.)
    }
    
    /**
     * Test the sendSMS method with an error response
     * 
     * TODO: Implement this test method to verify error handling in sendSMS
     */
    @IsTest
    static void testSendSMSError() {
        // TODO: Setup test data
        // - Create test phone number and message body
        
        // TODO: Setup mock callout response
        // - Use TwilioCalloutMock to simulate an error response
        
        // TODO: Execute the test
        // - Call TwilioService.sendSMS() method
        
        // TODO: Verify results
        // - Verify that response is not successful
        // - Verify error status code is correct
        // - Verify error message is extracted correctly
    }
    
    /**
     * Test the getMessages method
     * 
     * TODO: Implement this test method to verify the getMessages functionality
     */
    @IsTest
    static void testGetMessages() {
        // TODO: Setup mock callout response
        // - Use TwilioCalloutMock to simulate a successful response with message list
        
        // TODO: Execute the test
        // - Call TwilioService.getMessages() method with an appropriate limit
        
        // TODO: Verify results
        // - Verify that response is successful
        // - Verify status code is correct
        // - Verify response body contains expected messages data
    }
    
    /**
     * Test the getMessages method with null/invalid limit
     * 
     * TODO: Implement this test method to verify handling of edge cases
     */
    @IsTest
    static void testGetMessagesWithInvalidLimit() {
        // TODO: Setup mock callout response
        // - Use TwilioCalloutMock to simulate a successful response
        
        // TODO: Execute the test with null limit
        // - Call TwilioService.getMessages() method with null
        
        // TODO: Execute the test with negative limit
        // - Call TwilioService.getMessages() method with a negative number
        
        // TODO: Verify results
        // - Verify that both responses are successful
        // - Verify that the service handles these edge cases correctly
    }
    
    /**
     * Test exception handling in makeHttpRequest
     * 
     * TODO: Implement this test method to verify exception handling
     */
    @IsTest
    static void testMakeHttpRequestException() {
        // TODO: Setup mock that throws exception
        // - Use TwilioCalloutMock.createExceptionMock()
        
        // TODO: Execute the test
        // - Call a TwilioService method that will use the mock
        
        // TODO: Verify results
        // - Verify that response indicates failure
        // - Verify that status code is set to 500 (or appropriate error code)
        // - Verify that error message is set correctly
    }
} 