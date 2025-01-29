import groovy.json.JsonSlurper;

// Get the response from the HTTP request
def responseBody = prev.getResponseDataAsString();
log.info("API Response: " + responseBody);

// Parse the response JSON
def jsonSlurper = new JsonSlurper();
def responseJson = jsonSlurper.parseText(responseBody);

// Get the remote result matrix
def remoteResult = responseJson.result;

// Get the locally computed matrix from JMeter variables
def localResult = vars.get("resultMatrix");

// Convert the stored JSON string back to an array
def localResultParsed = jsonSlurper.parseText(localResult);

// Compare both matrices
boolean isCorrect = (localResultParsed == remoteResult);

// Log the result
if (isCorrect) {
    log.info("✅ Matrix multiplication result is CORRECT!");
} else {
    log.error("❌ Matrix multiplication result is INCORRECT!");
    log.error("Expected: " + localResultParsed);
    log.error("Received: " + remoteResult);
}

// Store the verification status in a JMeter variable
vars.put("verificationStatus", isCorrect ? "PASS" : "FAIL");
