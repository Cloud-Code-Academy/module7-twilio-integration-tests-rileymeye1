/**
 * TwilioResponse - Wrapper class for Twilio API responses
 * Used to standardize response handling across the integration
 */
public with sharing class TwilioResponse {
    // Response properties
    public Boolean success { get; set; }
    public Integer statusCode { get; set; }
    public String body { get; set; }
    
    // Constructor
    public TwilioResponse() {
        this.success = false;
        this.statusCode = 0;
        this.body = '';
    }
    
    /**
     * Get the response as a JSON object if possible
     * @return Parsed JSON map or null if parsing fails
     */
    public Map<String, Object> getBodyAsJson() {
        try {
            if (String.isNotBlank(this.body)) {
                return (Map<String, Object>) JSON.deserializeUntyped(this.body);
            }
        } catch (Exception e) {
            System.debug('Error parsing response as JSON: ' + e.getMessage());
        }
        return null;
    }
    
    /**
     * Get an error message from the response if present
     * @return Error message or null if no error found
     */
    public String getErrorMessage() {
        if (!this.success) {
            Map<String, Object> jsonBody = getBodyAsJson();
            if (jsonBody != null && jsonBody.containsKey('message')) {
                return String.valueOf(jsonBody.get('message'));
            } else if (jsonBody != null && jsonBody.containsKey('error_message')) {
                return String.valueOf(jsonBody.get('error_message'));
            } else if (jsonBody != null && jsonBody.containsKey('error')) {
                return String.valueOf(jsonBody.get('error'));
            }
        }
        return null;
    }
}