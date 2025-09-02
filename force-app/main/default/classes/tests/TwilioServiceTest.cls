/**
 * TwilioServiceTest - Test class for TwilioService
 * @see TwilioService
 */
@IsTest
private class TwilioServiceTest {
    
    /**
     * Test the sendSMS method with a valid request
     */
    @IsTest
    static void testSendSMS() {
        String phoneNumber = '+18777804236';
        String messageBody = 'Hello, this is a test message!';
        String responseBody = '{"account_sid":"fakeID","api_version":"2010-04-01","body":"Hello, this is a test message!","date_created":"Mon, 01 Sep 2025 18:03:39 +0000","date_sent":null,"date_updated":"Mon, 01 Sep 2025 18:03:39 +0000","direction":"outbound-api","error_code":null,"error_message":null,"from":"+18555920256","messaging_service_sid":null,"num_media":"0","num_segments":"1","price":null,"price_unit":"USD","sid":"fakeId","status":"queued","subresource_uris":{"media":"/2010-04-01/Accounts/fakeId/Messages/fakeId/Media.json"},"to":"+18777804236","uri":"/2010-04-01/Accounts/fakeId/Messages/fakeId.json"}';

        Test.setMock(HttpCalloutMock.class, new TwilioCalloutMock(201, responseBody));
        
        Test.startTest();
        TwilioResponse response = TwilioService.sendSMS(phoneNumber, messageBody);
        Test.stopTest();
        
        System.assertEquals(true, response.success, 'The response should be successful');
        System.assertEquals(201, response.statusCode, 'The response status code should be a 201');
        System.assertEquals(true, response.body.contains('account_sid'), 'The response body should contain the account_sid');
        System.assertEquals(true, response.body.contains('queued'), 'The response body should contain the status of queued');
    }
    
    /**
     * Test the sendSMS method with an error response key "message"
     */
    @IsTest
    static void testSendSMSMessagePath1() {
        String phoneNumber = '+18777804236';
        String messageBody = 'Hello, this is an error test message!';
        String responseBody = '{"code":30008,"message":"Unknown error","log_level":"ERROR","secondary_message":null,"log_type":"CARRIER","docs":"","causes":"","solutions":"","description":"Error - 30008 Message Delivery - Unknown error","product":"Programmable SMS","date_created":"2016-03-31T17:14:35Z","last_updated":"2025-01-06T14:08:51.122763Z"}';
        
        Test.setMock(HttpCalloutMock.class, new TwilioCalloutMock(410, responseBody));

        Test.startTest();
        TwilioResponse response = TwilioService.sendSMS(phoneNumber, messageBody);
        Test.stopTest();
        
        System.assertEquals(false, response.success, 'The response should be a failure');
        System.assertEquals(410, response.statusCode, 'The response status code should be a 410');
        System.assertEquals('Unknown error', response.getErrorMessage(), 'The error message should be "Unknown error"');
    }

    /**
     * Test the sendSMS method with an error response key "error_message
     */
    @IsTest
    static void testSendSMSMessagePath2() {
        String phoneNumber = '+18777804236';
        String messageBody = 'Hello, this is an error test message!';
        String responseBody = '{"code":30008,"error_message":"Unknown error","log_level":"ERROR","secondary_message":null,"log_type":"CARRIER","docs":"","causes":"","solutions":"","description":"Error - 30008 Message Delivery - Unknown error","product":"Programmable SMS","date_created":"2016-03-31T17:14:35Z","last_updated":"2025-01-06T14:08:51.122763Z"}';
        
        Test.setMock(HttpCalloutMock.class, new TwilioCalloutMock(410, responseBody));

        Test.startTest();
        TwilioResponse response = TwilioService.sendSMS(phoneNumber, messageBody);
        Test.stopTest();
        
        System.assertEquals(false, response.success, 'The response should be a failure');
        System.assertEquals(410, response.statusCode, 'The response status code should be a 410');
        System.assertEquals('Unknown error', response.getErrorMessage(), 'The error message should be "Unknown error"');
    }

    /**
     * Test the sendSMS method with an error response key "error"
     */
    @IsTest
    static void testSendSMSMessagePath3() {
        String phoneNumber = '+18777804236';
        String messageBody = 'Hello, this is an error test message!';
        String responseBody = '{"code":30008,"error":"Unknown error","log_level":"ERROR","secondary_message":null,"log_type":"CARRIER","docs":"","causes":"","solutions":"","description":"Error - 30008 Message Delivery - Unknown error","product":"Programmable SMS","date_created":"2016-03-31T17:14:35Z","last_updated":"2025-01-06T14:08:51.122763Z"}';
        
        Test.setMock(HttpCalloutMock.class, new TwilioCalloutMock(410, responseBody));

        Test.startTest();
        TwilioResponse response = TwilioService.sendSMS(phoneNumber, messageBody);
        Test.stopTest();
        
        System.assertEquals(false, response.success, 'The response should be a failure');
        System.assertEquals(410, response.statusCode, 'The response status code should be a 410');
        System.assertEquals('Unknown error', response.getErrorMessage(), 'The error message should be "Unknown error"');
    }
    
    /**
     * Test the getMessages method
     */
    @IsTest
    static void testGetMessages() {
        String responseBody = '{"end":1,"first_page_uri":"/2010-04-01/Accounts/ACaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa/Messages.json?To=%2B123456789&From=%2B987654321&DateSent%3E=2008-01-02&PageSize=2&Page=0","next_page_uri":"/2010-04-01/Accounts/ACaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa/Messages.json?To=%2B123456789&From=%2B987654321&DateSent%3E=2008-01-02&PageSize=2&Page=1&PageToken=PAMMc26223853f8c46b4ab7dfaa6abba0a26","page":0,"page_size":2,"previous_page_uri":null,"messages":[{"account_sid":"ACaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa","api_version":"2010-04-01","body":"testing","date_created":"Fri, 24 May 2019 17:44:46 +0000","date_sent":"Fri, 24 May 2019 17:44:50 +0000","date_updated":"Fri, 24 May 2019 17:44:50 +0000","direction":"outbound-api","error_code":null,"error_message":null,"from":"+12019235161","messaging_service_sid":"MGaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa","num_media":"0","num_segments":"1","price":"-0.00750","price_unit":"USD","sid":"SMded05904ccb347238880ca9264e8fe1c","status":"sent","subresource_uris":{"media":"/2010-04-01/Accounts/ACaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa/Messages/SMded05904ccb347238880ca9264e8fe1c/Media.json","feedback":"/2010-04-01/Accounts/ACaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa/Messages/SMded05904ccb347238880ca9264e8fe1c/Feedback.json"},"to":"+18182008801","uri":"/2010-04-01/Accounts/ACaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa/Messages/SMded05904ccb347238880ca9264e8fe1c.json"},{"account_sid":"ACaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa","api_version":"2010-04-01","body":"look mom I have media!","date_created":"Fri, 24 May 2019 17:44:46 +0000","date_sent":"Fri, 24 May 2019 17:44:49 +0000","date_updated":"Fri, 24 May 2019 17:44:49 +0000","direction":"inbound","error_code":30004,"error_message":"Message blocked","from":"+12019235161","messaging_service_sid":"MGaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa","num_media":"3","num_segments":"1","price":"-0.00750","price_unit":"USD","sid":"MMc26223853f8c46b4ab7dfaa6abba0a26","status":"received","subresource_uris":{"media":"/2010-04-01/Accounts/ACaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa/Messages/MMc26223853f8c46b4ab7dfaa6abba0a26/Media.json","feedback":"/2010-04-01/Accounts/ACaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa/Messages/MMc26223853f8c46b4ab7dfaa6abba0a26/Feedback.json"},"to":"+18182008801","uri":"/2010-04-01/Accounts/ACaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa/Messages/MMc26223853f8c46b4ab7dfaa6abba0a26.json"}],"start":0,"uri":"/2010-04-01/Accounts/ACaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa/Messages.json?To=%2B123456789&From=%2B987654321&DateSent%3E=2008-01-02&PageSize=2&Page=0"}';
        
        Test.setMock(HttpCalloutMock.class, new TwilioCalloutMock(200, responseBody));
        
        Test.startTest();
        TwilioResponse response = TwilioService.getMessages(1);
        Test.stopTest();
        
        System.assertEquals(true, response.success, 'The response should be successful');
        System.assertEquals(200, response.statusCode, 'The response status code should be a 200');

        Map<String, Object> responseKeyToValue = response.getBodyAsJson();
        Assert.isTrue(responseKeyToValue.containsKey('messages'), 'The response should contain a "messages" key');
        Assert.isTrue(responseKeyToValue.containsKey('first_page_uri'), 'The response should contain a "first_page_uri" key');
        Assert.isTrue(responseKeyToValue.containsKey('next_page_uri'), 'The response should contain a "next_page_uri" key');
        Assert.isTrue(responseKeyToValue.containsKey('previous_page_uri'), 'The response should contain a "previous_page_uri" key');
        Assert.isTrue(responseKeyToValue.containsKey('page'), 'The response should contain a "page" key');
    }
    
    /**
     * Test the getMessages method with null/invalid limit
     */
    @IsTest
    static void testGetMessagesWithInvalidLimit() {
        String responseBody = '{"end":1,"first_page_uri":"/2010-04-01/Accounts/ACaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa/Messages.json?To=%2B123456789&From=%2B987654321&DateSent%3E=2008-01-02&PageSize=2&Page=0","next_page_uri":"/2010-04-01/Accounts/ACaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa/Messages.json?To=%2B123456789&From=%2B987654321&DateSent%3E=2008-01-02&PageSize=2&Page=1&PageToken=PAMMc26223853f8c46b4ab7dfaa6abba0a26","page":0,"page_size":2,"previous_page_uri":null,"messages":[{"account_sid":"ACaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa","api_version":"2010-04-01","body":"testing","date_created":"Fri, 24 May 2019 17:44:46 +0000","date_sent":"Fri, 24 May 2019 17:44:50 +0000","date_updated":"Fri, 24 May 2019 17:44:50 +0000","direction":"outbound-api","error_code":null,"error_message":null,"from":"+12019235161","messaging_service_sid":"MGaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa","num_media":"0","num_segments":"1","price":"-0.00750","price_unit":"USD","sid":"SMded05904ccb347238880ca9264e8fe1c","status":"sent","subresource_uris":{"media":"/2010-04-01/Accounts/ACaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa/Messages/SMded05904ccb347238880ca9264e8fe1c/Media.json","feedback":"/2010-04-01/Accounts/ACaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa/Messages/SMded05904ccb347238880ca9264e8fe1c/Feedback.json"},"to":"+18182008801","uri":"/2010-04-01/Accounts/ACaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa/Messages/SMded05904ccb347238880ca9264e8fe1c.json"},{"account_sid":"ACaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa","api_version":"2010-04-01","body":"look mom I have media!","date_created":"Fri, 24 May 2019 17:44:46 +0000","date_sent":"Fri, 24 May 2019 17:44:49 +0000","date_updated":"Fri, 24 May 2019 17:44:49 +0000","direction":"inbound","error_code":30004,"error_message":"Message blocked","from":"+12019235161","messaging_service_sid":"MGaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa","num_media":"3","num_segments":"1","price":"-0.00750","price_unit":"USD","sid":"MMc26223853f8c46b4ab7dfaa6abba0a26","status":"received","subresource_uris":{"media":"/2010-04-01/Accounts/ACaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa/Messages/MMc26223853f8c46b4ab7dfaa6abba0a26/Media.json","feedback":"/2010-04-01/Accounts/ACaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa/Messages/MMc26223853f8c46b4ab7dfaa6abba0a26/Feedback.json"},"to":"+18182008801","uri":"/2010-04-01/Accounts/ACaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa/Messages/MMc26223853f8c46b4ab7dfaa6abba0a26.json"}],"start":0,"uri":"/2010-04-01/Accounts/ACaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa/Messages.json?To=%2B123456789&From=%2B987654321&DateSent%3E=2008-01-02&PageSize=2&Page=0"}';
        
        Test.setMock(HttpCalloutMock.class, new TwilioCalloutMock(200, responseBody));
        
        Test.startTest();
        TwilioResponse nullResponse = TwilioService.getMessages(null);
        TwilioResponse negativeNumResponse = TwilioService.getMessages(-1);
        Test.stopTest();

        // The TwilioService.getMessages() method is designed to override null or negative arguments with 20
        System.assertEquals(true, nullResponse.success, 'The response should be successful');
        System.assertEquals(200, nullResponse.statusCode, 'The response status code should be a 200');
        System.assertEquals(true, negativeNumResponse.success, 'The response should be successful');
        System.assertEquals(200, negativeNumResponse.statusCode, 'The response status code should be a 200');
    }
    
    /**
     * Test exception handling in makeHttpRequest
     */
    @IsTest
    static void testMakeHttpRequestException() {
        String phoneNumber = '+18777804236';
        String messageBody = 'Hello, this is a test message!';

        Test.setMock(HttpCalloutMock.class, TwilioCalloutMock.createExceptionMock());
        
        Test.startTest();
        TwilioResponse response = TwilioService.sendSMS(phoneNumber, messageBody);
        Test.stopTest();

        System.assertEquals(false, response.success, 'The response should be a failure');
        System.assertEquals(500, response.statusCode, 'The response status code should be a 500');
        System.assertEquals('{"error": "An error occurred while processing the request."}', response.body, 'The response body should be the default error message');
    }
}