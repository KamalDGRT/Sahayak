//
// TypeAliases.swift
// Sahayak
//

import Foundation

public typealias EmptyClosure = () -> Void

public typealias ApiSuccessResponse<T: Codable> = (T, HTTPStatusCode) -> Void
public typealias ApiErrorResponse = (ApiError, HTTPStatusCode) -> Void

public typealias StringDictionary = [String: String]
public typealias JsonDictionary = [String: Any]
