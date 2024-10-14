// AUTO-GENERATED FILE. DO NOT MODIFY.
// This file is auto-generated by the Ballerina OpenAPI tool.

import ballerina/http;

# API for managing Programme development and review workflow at Namibia University of Science and Technology.
public isolated client class Client {
    final http:Client clientEp;
    # Gets invoked to initialize the `connector`.
    #
    # + config - The configurations to be used when initializing the `connector` 
    # + serviceUrl - URL of the target service 
    # + return - An error if connector initialization failed 
    public isolated function init(ConnectionConfig config =  {}, string serviceUrl = "http://localhost:8080") returns error? {
        http:ClientConfiguration httpClientConfig = {httpVersion: config.httpVersion, timeout: config.timeout, forwarded: config.forwarded, poolConfig: config.poolConfig, compression: config.compression, circuitBreaker: config.circuitBreaker, retryConfig: config.retryConfig, validation: config.validation};
        do {
            if config.http1Settings is ClientHttp1Settings {
                ClientHttp1Settings settings = check config.http1Settings.ensureType(ClientHttp1Settings);
                httpClientConfig.http1Settings = {...settings};
            }
            if config.http2Settings is http:ClientHttp2Settings {
                httpClientConfig.http2Settings = check config.http2Settings.ensureType(http:ClientHttp2Settings);
            }
            if config.cache is http:CacheConfig {
                httpClientConfig.cache = check config.cache.ensureType(http:CacheConfig);
            }
            if config.responseLimits is http:ResponseLimitConfigs {
                httpClientConfig.responseLimits = check config.responseLimits.ensureType(http:ResponseLimitConfigs);
            }
            if config.secureSocket is http:ClientSecureSocket {
                httpClientConfig.secureSocket = check config.secureSocket.ensureType(http:ClientSecureSocket);
            }
            if config.proxy is http:ProxyConfig {
                httpClientConfig.proxy = check config.proxy.ensureType(http:ProxyConfig);
            }
        }
        http:Client httpEp = check new (serviceUrl, httpClientConfig);
        self.clientEp = httpEp;
        return;
    }

    # Delete a programme by its programme code
    #
    # + headers - Headers to be sent with the request 
    # + return - Programme deleted successfully 
    resource isolated function delete programmes/[string programmeCode](map<string|string[]> headers = {}) returns http:Response|error {
        string resourcePath = string `/programmes/${getEncodedUri(programmeCode)}`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Retrieve a list of all programmes
    #
    # + headers - Headers to be sent with the request 
    # + return - List of all programmes 
    resource isolated function get programmes(map<string|string[]> headers = {}) returns Programme[]|error {
        string resourcePath = string `/programmes`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Retrieve details of a specific programme by its programme code
    #
    # + headers - Headers to be sent with the request 
    # + return - Details of the requested programme 
    resource isolated function get programmes/[string programmeCode](map<string|string[]> headers = {}) returns Programme|error {
        string resourcePath = string `/programmes/${getEncodedUri(programmeCode)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Retrieve all programmes belonging to a specific faculty
    #
    # + headers - Headers to be sent with the request 
    # + return - List of programmes for the specified faculty 
    resource isolated function get programmes/faculty/[string facultyName](map<string|string[]> headers = {}) returns Programme[]|error {
        string resourcePath = string `/programmes/faculty/${getEncodedUri(facultyName)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    resource isolated function get programmes/review\-due(map<string|string[]> headers = {}) returns Programme[]|error {
        string resourcePath = string `/programmes/review-due`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Add a new programme
    #
    # + headers - Headers to be sent with the request 
    # + return - Programme added successfully 
    resource isolated function post programmes(Programme payload, map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/programmes`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Update an existing programme's information
    #
    # + headers - Headers to be sent with the request 
    # + return - Programme updated successfully 
    resource isolated function put programmes/[string programmeCode](Programme payload, map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/programmes/${getEncodedUri(programmeCode)}`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->put(resourcePath, request, headers);
    }
}
