//
//  ApiRequest.swift
//  Sahayak
//
//  Created by Kamal Sharma on 11/08/24.
//

import Foundation

public struct ApiRequest {
    /// The HTTP request method to use for this request.
    var method: HTTPMethod = .get
    
    /// The url of the API server. Example: `https://yourapp.com`
    var baseUrl = ""
    
    /// The endpoint resource of this API request e.g. `scheme://host<RESOURCE>` where <RESOURCE> could be `/info`, etc. NOTE: The preceeding forward slash is required.
    var endPoint = ""
    
    /// Optional headers to include in your request.
    var requestHeaders: [String: String]? = nil
    
    /// The request body that will be sent. Mostly used for POST/PUT/PATCH calls
    var requestBody: [String: Any]? = nil
    
    /// The URL query parameters of this request, if any.
    var urlQueryParameters: [String: String]? = nil
    
    /// The form data for request type where the content is of type `application/x-www-form-urlencoded`
    var formData: [String: String]? = nil
    
    public init(
        method: HTTPMethod,
        baseUrl: String = "",
        endPoint: String = "",
        requestHeaders: [String : String]? = nil,
        requestBody: [String : Any]? = nil,
        urlQueryParameters: [String : String]? = nil,
        formData: [String : String]? = nil
    ) {
        self.method = method
        self.baseUrl = baseUrl
        self.endPoint = endPoint
        self.requestHeaders = requestHeaders
        self.requestBody = requestBody
        self.urlQueryParameters = urlQueryParameters
        self.formData = formData
    }
    
    public func toString() -> String {
        var str = "{\n"
        str += "method: " + method.rawValue + ",\n"
        str += "baseUrl: " + baseUrl + ",\n"
        str += "endPoint: " + endPoint + ",\n"
        str += "requestHeaders: " + (requestHeaders?.toJsonString ?? "") + ",\n"
        str += "requestBody: " + (requestBody?.toJsonString ?? "") + ",\n"
        str += "urlQueryParameters: " + (urlQueryParameters?.toJsonString ?? "") + ",\n"
        str += "formData: " + (formData?.toJsonString ?? "") + "\n"
        str += "}\n"
        return str
    }
}
