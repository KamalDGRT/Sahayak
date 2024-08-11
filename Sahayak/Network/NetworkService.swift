//
//  NetworkService.swift
//  Sahayak
//

import UIKit

public typealias ApiSuccessResponse<T: Codable> = (T, HTTPStatusCode) -> Void
public typealias ApiErrorResponse = (ApiError, HTTPStatusCode) -> Void

public struct NetworkService {
    
    public static let shared = NetworkService()
    
    // Singleton that Only allows one instance of this class
    private init() {}
    
    /// Default headers to include in your request. You can set this preferrably in the `AppDelegate`.
    public var defaultHeaders: [String: String]? = nil
    
    /// With this, you can set your own configuration for the Network Calls in your `AppDelegate`.
    public var urlSessionConfig: URLSessionConfiguration?
    
    private var urlSession: URLSession {
        if let urlSessionConfig {
            return URLSession(configuration: urlSessionConfig)
        } else {
            let config = URLSessionConfiguration.default
            config.tlsMinimumSupportedProtocolVersion = .TLSv13
            config.urlCache = nil
            
            return URLSession(configuration: config)
        }
    }
    
    public func request<T: Codable>(
        _ apiRequest: ApiRequest,
        apiSuccess: @escaping(ApiSuccessResponse<T>),
        apiFailure: @escaping(ApiErrorResponse)
    ) {
        
        guard apiRequest.baseUrl.isNotBlank else {
            apiFailure(.emptyBaseUrl, .badRequest)
            return
        }
        
        var urlComponents = URLComponents(string: apiRequest.baseUrl)
        urlComponents?.path = apiRequest.endPoint
        
        /// adding query params
        if let queryParams = apiRequest.urlQueryParameters {
            urlComponents?.queryItems = queryParams.map {
                URLQueryItem(name: $0, value: $1)
            }
        }
        
        guard let endpointUrl = urlComponents?.url else {
            apiFailure(.malformedUrl, .badRequest)
            return
        }
        
        var requestHeaders = [String: String]()
        /// Default Request Headers
        if let defaultRequestHeaders = defaultHeaders {
            for reqHead in defaultRequestHeaders {
                requestHeaders[reqHead.key] = reqHead.value
            }
        }
        /// Request Headers that are sent in the specific API endpoint call which can be used to override the default headers.
        if let reqHeaders = apiRequest.requestHeaders {
            for reqHead in reqHeaders {
                requestHeaders[reqHead.key] = reqHead.value
            }
        }
        
        /// creating the actual Swift-Style API Request
        // Construct our web request.
        var webRequest = URLRequest(url: endpointUrl)
        webRequest.httpMethod = apiRequest.method.rawValue
        
        if let requestBody = apiRequest.requestBody?.jsonData {
            webRequest.httpBody = requestBody
        }
        
        /// maybe the content-type can be checked in the headers list and then it can be unwrapped.
        //    if requestHeaders["Content-Type"].
        if let formData = apiRequest.formData {
            webRequest.httpBody = formData.urlEncodedString.data(using: .utf8)
        }
        
        webRequest.cachePolicy = .useProtocolCachePolicy
        webRequest.timeoutInterval = 120
        webRequest.allHTTPHeaderFields = requestHeaders
        
        let dataTask = urlSession.dataTask(with: webRequest) { (data, response, error) in
            DispatchQueue.main.async {
                guard let apiResponse = response as? HTTPURLResponse,
                      let httpStatusCode = HTTPStatusCode(rawValue: apiResponse.statusCode) else {
                    apiFailure(.invalidResponse, .badRequest)
                    return
                }
                
                /// Api call succeeded
                if apiResponse.statusCode >= 200 &&
                    apiResponse.statusCode < 399 &&
                    error == nil {
                    /// Handling error  while parsing the data
                    guard let reponseData: T = data?.jsonDecoder() else {
                        apiFailure(.decoding, .badRequest)
                        return
                    }
                    apiSuccess(reponseData, httpStatusCode)
                } else if let jsonData = data {
                    apiFailure(.serverErrorWithData(data: jsonData), httpStatusCode)
                    return
                } else {
                    /// no data and failure implies internal server error
                    apiFailure(.internalServerError, httpStatusCode)
                }
            } // Dispatch Queue
        } // urlSession
        dataTask.resume()
    } // request
    
    
    /// Asynchronously downloads an image from a URL.
    ///
    /// - Parameter urlString: The URL string from which to download the image.
    /// - Returns: A `UIImage` object representing the downloaded image.
    /// - Throws: An error if the URL is invalid or if there's an issue with downloading or decoding the image data.
    public func asyncImageDownload(urlString: String) async throws -> UIImage {
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let data = try? await URLSession.shared.data(from: url)
        
        guard let data else {
            throw URLError(.cannotDecodeRawData)
        }
        
        guard let image = UIImage(data: data.0) else {
            throw URLError(.cannotDecodeRawData)
        }
        
        return image
    }
}
