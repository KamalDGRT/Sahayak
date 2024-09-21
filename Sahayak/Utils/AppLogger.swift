//
// AppLogger.swift
// Sahayak
//

import os
import Foundation

public struct AppLogger {
  private let logger: Logger
  private var isLoggingAllowed: Bool
  
  public init(
    subSystem: String = "AppLogger",
    category: String = "default",
    isLoggingAllowed: Bool = false
  ) {
    self.isLoggingAllowed = isLoggingAllowed
    self.logger = Logger(subsystem: subSystem, category: category)
  }
}

public extension AppLogger {
  func defaultLog(
    _ message: String,
    file: String = #file,
    function: String = #function,
    line: Int = #line
  ) {
    if isLoggingAllowed {
      log(level: .default, message: message, file: file, function: function, line: line)
    }
  }
  
  func info(
    _ message: String,
    file: String = #file,
    function: String = #function,
    line: Int = #line
  ) {
    if isLoggingAllowed {
      log(level: .info, message: message, file: file, function: function, line: line)
    }
  }
  
  func debug(
    _ message: String,
    file: String = #file,
    function: String = #function,
    line: Int = #line
  ) {
    if isLoggingAllowed {
      log(level: .debug, message: message, file: file, function: function, line: line)
    }
  }
  
  func error(
    _ message: String,
    file: String = #file,
    function: String = #function,
    line: Int = #line
  ) {
    if isLoggingAllowed {
      log(level: .error, message: message, file: file, function: function, line: line)
    }
  }
  
  func fault(
    _ message: String,
    file: String = #file,
    function: String = #function,
    line: Int = #line
  ) {
    if isLoggingAllowed {
      log(level: .fault, message: message, file: file, function: function, line: line)
    }
  }
}

private extension AppLogger {
  func log(
    level: OSLogType,
    message: String,
    file: String,
    function: String,
    line: Int
  ) {
    if isLoggingAllowed {
      let fileName = (file as NSString).lastPathComponent
      let functionName = function.components(separatedBy: "(").first ?? function
      logger.log(level: level, "\(fileName):\(line) \(functionName)() - \(message, privacy: .public)")
    }
  }
}
