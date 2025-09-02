@IsTest
private class TwilioRestApiTest {
    
    /**
     * Test handleIncomingSMS method with standard SMS parameters
     */
    @IsTest
    static void testHandleIncomingSMSStandard() {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();

        req.requestURI = '/services/apexrest/twilio/sms';
        req.httpMethod = 'POST';

        req.addParameter('MessageSid', 'SM1234567890abcdef');
        req.addParameter('AccountSid', 'AC1234567890abcdef');
        req.addParameter('MessagingServiceSid', 'MG1234567890abcdef');
        req.addParameter('From', '+15551234567');
        req.addParameter('To', '+15559876543');
        req.addParameter('Body', 'Hello, World!');
        
        RestContext.request = req;
        RestContext.response = res;
        
        Test.startTest();
        String response = TwilioRestApi.handleIncomingSMS();
        Test.stopTest();
        
        Assert.isTrue(response != null, 'The response should not be null');
        Assert.isTrue(response.contains('<Response>'), 'The response should contain an opening <Response> element');
        Assert.isTrue(response.contains('</Response>'), 'The response should contain a closing </Response> element');
    }
    
    /**
     * Test handleIncomingSMS method with media attachments
     */
    @IsTest
    static void testHandleIncomingSMSWithMedia() {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();

        req.requestURI = '/services/apexrest/twilio/sms';
        req.httpMethod = 'POST';

        req.addParameter('MessageSid', 'SM1234567890abcdef');
        req.addParameter('AccountSid', 'AC1234567890abcdef');
        req.addParameter('MessagingServiceSid', 'MG1234567890abcdef');
        req.addParameter('From', '+15551234567');
        req.addParameter('To', '+15559876543');
        req.addParameter('Body', 'Hello, World!');
        req.addParameter('NumMedia', '1');
        req.addParameter('NumSegments', '1');
        req.addParameter('MediaUrl0', 'https://example.com/image.jpg');
        req.addParameter('MediaContentType0', 'image/jpeg');
        
        RestContext.request = req;
        RestContext.response = res;
        
        Test.startTest();
        String response = TwilioRestApi.handleIncomingSMS();
        Test.stopTest();

        Assert.isTrue(response != null, 'The response should not be null');
        Assert.isTrue(response.contains('<Response>'), 'The response should contain an opening <Response> element');
        Assert.isTrue(response.contains('</Response>'), 'The response should contain a closing </Response> element');
    }
    
    /**
     * Test handleIncomingSMS method with location data
     */
    @IsTest
    static void testHandleIncomingSMSWithLocation() {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();

        req.requestURI = '/services/apexrest/twilio/sms';
        req.httpMethod = 'POST';

        req.addParameter('MessageSid', 'SM1234567890abcdef');
        req.addParameter('AccountSid', 'AC1234567890abcdef');
        req.addParameter('MessagingServiceSid', 'MG1234567890abcdef');
        req.addParameter('From', '+15551234567');
        req.addParameter('To', '+15559876543');
        req.addParameter('Body', 'Hello, World!');
        req.addParameter('FromCity', 'San Francisco');
        req.addParameter('FromState', 'CA');
        req.addParameter('FromZip', '94105');
        req.addParameter('FromCountry', 'US');
        req.addParameter('ToCity', 'Omaha');
        req.addParameter('ToState', 'NE');
        req.addParameter('ToZip', '68110');
        req.addParameter('ToCountry', 'US');
        
        RestContext.request = req;
        RestContext.response = res;
        
        Test.startTest();
        String response = TwilioRestApi.handleIncomingSMS();
        Test.stopTest();

        Assert.isTrue(response != null, 'The response should not be null');
        Assert.isTrue(response.contains('<Response>'), 'The response should contain an opening <Response> element');
        Assert.isTrue(response.contains('</Response>'), 'The response should contain a closing </Response> element');
    }
    
    /**
     * Test handleIncomingSMS method with WhatsApp parameters
     */
    @IsTest
    static void testHandleIncomingSMSWithWhatsApp() {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();

        req.requestURI = '/services/apexrest/twilio/sms';
        req.httpMethod = 'POST';

        req.addParameter('MessageSid', 'SM1234567890abcdef');
        req.addParameter('AccountSid', 'AC1234567890abcdef');
        req.addParameter('MessagingServiceSid', 'MG1234567890abcdef');
        req.addParameter('From', 'whatsapp:+15551234567');
        req.addParameter('To', 'whatsapp:+15559876543');
        req.addParameter('Body', 'Hello, World!');
        req.addParameter('ProfileName', 'John Doe');
        req.addParameter('WaId', '1234567890');
        req.addParameter('Forwarded', 'false');
        req.addParameter('FrequentlyForwarded', 'false');
        req.addParameter('ButtonText', 'Click Here');
        req.addParameter('Latitude', '37.7749');
        req.addParameter('Longitude', '-122.4194');
        req.addParameter('Address', '1 Market St, San Francisco, CA 94105');
        req.addParameter('Label', 'San Francisco');
        
        RestContext.request = req;
        RestContext.response = res;
        
        Test.startTest();
        String response = TwilioRestApi.handleIncomingSMS();
        Test.stopTest();

        Assert.isTrue(response != null, 'The response should not be null');
        Assert.isTrue(response.contains('<Response>'), 'The response should contain an opening <Response> element');
        Assert.isTrue(response.contains('</Response>'), 'The response should contain a closing </Response> element');
    }
}