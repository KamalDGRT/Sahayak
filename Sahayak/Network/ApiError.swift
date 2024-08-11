//
//  ApiError.swift
//  Sahayak
//
//  Created by Kamal Sharma on 11/08/24.
//

import Foundation

/// An error resulting from an operation failing during normal APIClient operation.
public enum ApiError: Error {
    /// An error occurred while creating the request body.
    case badRequestBody
    
    /// An error occurred during decoding the API response.
    case decoding
    
    /// A request url was malformed
    case malformedUrl
    
    ///  Error occured while trying to parse the API response.
    case badResponse
    
    ///  Typical Interal Server error.
    case internalServerError
    
    /// API is able to give some response data upon failure.
    case serverErrorWithData(data: Data)
}

extension ApiError: CustomStringConvertible {
    /// Returns a string describing the error.
    public var description: String {
        switch self {
        case .badRequestBody:
            return "The request body has not been created in the way the API expects."
        case .decoding:
            return "An error occurred during decoding the API response to a suitable class/struct."
        case .malformedUrl:
            return "The request URL is not proper/valid."
        case .badResponse:
            return "An error occurred while parsing the API response."
        case .internalServerError:
            return "Typical Internal server "
        case .serverErrorWithData(let data):
            return "API call has failed but the server has returned a response.\nResponse: \(data.toString)"
        }
    }
}
