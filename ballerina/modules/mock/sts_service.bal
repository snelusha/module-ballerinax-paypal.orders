// Copyright (c) 2025, WSO2 LLC. (http://www.wso2.com).
//
// WSO2 LLC. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/http;
import ballerina/log;

configurable int HTTP_SERVER_PORT = 9444;
configurable int TOKEN_VALIDITY_PERIOD = 10000;

listener http:Listener sts = new (HTTP_SERVER_PORT);

service /oauth2 on sts {
    function init() {
        log:printInfo("STS started on port: " + HTTP_SERVER_PORT.toString() + " (HTTP)");
    }

    resource function post token(http:Request req) returns json|http:Unauthorized|http:BadRequest|http:InternalServerError {
        json response = {
            "access_token": "test-access-token",
            "token_type": "example",
            "expires_in": TOKEN_VALIDITY_PERIOD,
            "example_parameter": "example_value"
        };
        return response;
    }

    resource function post introspect(http:Request req) returns json|http:Unauthorized|http:BadRequest {
        json response = {
            "active": true,
            "scope": "read write",
            "client_id": "test-client-id",
            "username": "test-user",
            "token_type": "example",
            "exp": TOKEN_VALIDITY_PERIOD,
            "iat": 1419350238,
            "nbf": 1419350238,
            "sub": "Z5O3upPC88QrAjx00dis",
            "aud": "https://protected.example.net/resource",
            "iss": "https://server.example.com/",
            "jti": "JlbmMiOiJBMTI4Q0JDLUhTMjU2In",
            "extension_field": "twenty-seven",
            "scp": "admin"
        };
        return response;
    }

}
