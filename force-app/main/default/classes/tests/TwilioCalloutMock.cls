@IsTest
public class TwilioCalloutMock implements HttpCalloutMock {
    private Integer statusCode;
    private String responseBody;
    private Boolean throwException;
    private String exceptionMessage;
    
    public TwilioCalloutMock(Integer statusCode, String responseBody) {
        this.throwException = false;
        this.statusCode = statusCode;
        this.responseBody = responseBody;
    }
    
    public TwilioCalloutMock(String exceptionMessage) {
        this.throwException = true;
        this.exceptionMessage = exceptionMessage;
    }
    
    public static TwilioCalloutMock createExceptionMock() {
        return new TwilioCalloutMock('An error occurred while processing the request.');
    }
    
    public HttpResponse respond(HttpRequest request) {
        if (this.throwException) {
            throw new CalloutException(this.exceptionMessage);
        } else {
            HttpResponse response = new HttpResponse();
            response.setStatusCode(this.statusCode);
            response.setBody(this.responseBody);
            return response;
        }
    }
}