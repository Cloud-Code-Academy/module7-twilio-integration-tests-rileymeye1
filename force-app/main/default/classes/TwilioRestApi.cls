/**
 * TwilioRestApi - REST API for Twilio SMS integration
 * Exposes endpoints for sending and retrieving SMS messages
 * HTTP Methods: GET (fetch messages), POST (send messages), PUT (update preferences)
 */
@RestResource(urlMapping='/twilio/sms/*')
global with sharing class TwilioRestApi {
    
    /**
     * Handles incoming SMS webhook requests from Twilio
     * Parses and logs the message details from the request parameters
     * @return String Response to Twilio
     */
    @HttpPost
    global static String handleIncomingSMS() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        
        // Parse standard Twilio webhook parameters
        String messageSid = req.params.get('MessageSid');
        String accountSid = req.params.get('AccountSid');
        String messagingServiceSid = req.params.get('MessagingServiceSid');
        String fromNumber = req.params.get('From');
        String toNumber = req.params.get('To');
        String body = req.params.get('Body');
        String numMedia = req.params.get('NumMedia');
        String numSegments = req.params.get('NumSegments');
        
        // Parse location data if available
        String fromCity = req.params.get('FromCity');
        String fromState = req.params.get('FromState');
        String fromZip = req.params.get('FromZip');
        String fromCountry = req.params.get('FromCountry');
        String toCity = req.params.get('ToCity');
        String toState = req.params.get('ToState');
        String toZip = req.params.get('ToZip');
        String toCountry = req.params.get('ToCountry');
        
        // Parse media data if available
        Integer mediaCount = numMedia != null ? Integer.valueOf(numMedia) : 0;
        List<String> mediaUrls = new List<String>();
        List<String> mediaTypes = new List<String>();
        
        for (Integer i = 0; i < mediaCount; i++) {
            String mediaUrl = req.params.get('MediaUrl' + i);
            String mediaType = req.params.get('MediaContentType' + i);
            
            if (mediaUrl != null) {
                mediaUrls.add(mediaUrl);
                mediaTypes.add(mediaType);
            }
        }
        
        // Parse WhatsApp specific parameters if available
        String profileName = req.params.get('ProfileName');
        String waId = req.params.get('WaId');
        String forwarded = req.params.get('Forwarded');
        String frequentlyForwarded = req.params.get('FrequentlyForwarded');
        String buttonText = req.params.get('ButtonText');
        
        // Location data for WhatsApp
        String latitude = req.params.get('Latitude');
        String longitude = req.params.get('Longitude');
        String address = req.params.get('Address');
        String label = req.params.get('Label');
        
        // Debug SMS information
        System.debug('Received SMS - MessageSID: ' + messageSid);
        System.debug('From: ' + fromNumber + ', To: ' + toNumber);
        System.debug('Body: ' + body);
        System.debug('Media Count: ' + mediaCount);
        
        for (Integer i = 0; i < mediaUrls.size(); i++) {
            System.debug('Media ' + i + ': ' + mediaUrls[i] + ' (' + mediaTypes[i] + ')');
        }
        
        if (fromCity != null || fromCountry != null) {
            System.debug('Sender Location - City: ' + fromCity + ', State: ' + fromState + 
                         ', Zip: ' + fromZip + ', Country: ' + fromCountry);
        }
        
        if (profileName != null || waId != null) {
            System.debug('WhatsApp Details - Profile: ' + profileName + ', WaId: ' + waId + 
                         ', Forwarded: ' + forwarded + ', FrequentlyForwarded: ' + frequentlyForwarded);
        }
        
        if (latitude != null || longitude != null) {
            System.debug('WhatsApp Location - Lat: ' + latitude + ', Long: ' + longitude + 
                         ', Address: ' + address + ', Label: ' + label);
        }
        
        // Return a simple response or TwiML if needed
        return '<?xml version="1.0" encoding="UTF-8"?><Response></Response>';
    }
}