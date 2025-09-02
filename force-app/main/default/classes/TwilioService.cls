/**
 * TwilioService - Core class for Twilio SMS integration
 * Handles sending and retrieving SMS messages via Twilio API
 */
public with sharing class TwilioService {
    // These values are set using the getTwilioSettings() method
    // Settings are stored in Custom Metadata Type Twilio_API_Setting__mdt
    private static Boolean settingsRetrieved = false;
    private static String accountSID;
    private static String authToken;
    private static String defaultFromNumber;
    private static String twilioApiUrl;


    /**
     * Send an SMS message via Twilio
     * @param toNumber - Recipient phone number (E.164 format)
     * @param messageBody - SMS message content
     * @param fromNumber - Optional sender phone number (defaults to DEFAULT_FROM_NUMBER)
     * @return TwilioResponse containing status and message details
     */
    public static TwilioResponse sendSMS(String toNumber, String messageBody) {
        if (settingsRetrieved == false) {
            getTwilioSettings();
        }

        // Prepare request parameters
        Map<String, String> params = new Map<String, String> {
            'To' => toNumber,
            'From' => defaultFromNumber,
            'Body' => messageBody
        };
        
        HttpResponse response = makeHttpRequest('POST', '/Messages.json', params);
        return parseResponse(response);
    }
    
    /**
     * Retrieve SMS messages from Twilio
     * @param limit - Maximum number of messages to retrieve (default: 20)
     * @return TwilioResponse containing status and list of messages
     */
    public static TwilioResponse getMessages(Integer pageLimit) {
        if (settingsRetrieved == false) {
            getTwilioSettings();
        }

        if (pageLimit == null || pageLimit <= 0) {
            pageLimit = 20;
        }
        
        Map<String, String> params = new Map<String, String> {
            'PageSize' => String.valueOf(pageLimit)
        };
        
        HttpResponse response = makeHttpRequest('GET', '/Messages.json', params);
        return parseResponse(response);
    }

    private static void getTwilioSettings() {
        Twilio_API_Setting__mdt twilioAPISettings = Twilio_API_Setting__mdt.getInstance('ACTIVE');
        accountSID = twilioAPISettings.Account_SID__c;
        authToken = twilioAPISettings.Auth_Token__c;
        defaultFromNumber = twilioAPISettings.Default_From_Number__c;
        twilioApiUrl = twilioAPISettings.Twilio_API_URL__c + accountSID;
    }
    
    /**
     * Common method to make HTTP requests to Twilio API
     */
    private static HttpResponse makeHttpRequest(String method, String endpoint, Map<String, String> params) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(twilioApiUrl + endpoint);
        request.setMethod(method);
        
        // Add Basic Auth header for Twilio authentication
        // Twilio uses HTTP Basic Auth with Account SID as username and Auth Token as password
        String authString = accountSID + ':' + authToken;
        Blob headerValue = Blob.valueOf(authString);
        String authorizationHeader = 'Basic ' + EncodingUtil.base64Encode(headerValue);
        request.setHeader('Authorization', authorizationHeader);
        
        // Set timeout to avoid long-running callouts
        request.setTimeout(20000); // 20 seconds timeout
        
        // Add parameters to request
        if (method == 'GET') {
            String queryParams = '';
            for (String key : params.keySet()) {
                if (queryParams != '') {
                    queryParams += '&';
                }
                queryParams += key + '=' + EncodingUtil.urlEncode(params.get(key), 'UTF-8');
            }
            if (queryParams != '') {
                String endpoint1 = request.getEndpoint();
                request.setEndpoint(endpoint1 + '?' + queryParams);
            }
        } else {
            // For POST and PUT requests, use form URL encoded format
            request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
            String requestBody = '';
            for (String key : params.keySet()) {
                if (requestBody != '') {
                    requestBody += '&';
                }
                requestBody += key + '=' + EncodingUtil.urlEncode(params.get(key), 'UTF-8');
            }
            request.setBody(requestBody);
        }
        
        try {
            System.debug('Sending request to: ' + request.getEndpoint());
            System.debug('With method: ' + method);
            if (method != 'GET') {
                System.debug('Request body: ' + request.getBody());
            }
            
            HttpResponse response = http.send(request);
            System.debug('Response status code: ' + response.getStatusCode());
            System.debug('Response body: ' + response.getBody());
            
            return response;
        } catch (Exception e) {
            System.debug('Error making HTTP request: ' + e.getMessage());
            // Handle exceptions
            HttpResponse errorResponse = new HttpResponse();
            errorResponse.setStatusCode(500);
            errorResponse.setBody('{"error": "' + e.getMessage() + '"}');
            return errorResponse;
        }
    }
    
    /**
     * Parse HTTP response from Twilio
     */
    private static TwilioResponse parseResponse(HttpResponse response) {
        TwilioResponse twilioResponse = new TwilioResponse();
        twilioResponse.statusCode = response.getStatusCode();
        twilioResponse.body = response.getBody();
        twilioResponse.success = (response.getStatusCode() >= 200 && response.getStatusCode() < 300);
        
        return twilioResponse;
    }
}