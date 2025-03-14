//
//  Log.swift
//
//  Created by Md. Mehedi Hasan on 29/9/21.
//

import Foundation

class Log {
    static var dateFormat = "yyyy-MM-dd hh:mm:ssSS"
    static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.dateFormat = dateFormat
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        return formatter
    }
    
    enum LogEvent: String {
        case error = "ERROR"
        case info = "INFO"
        case debug = "DEBUG"
        case warn = "WARNING"
        case severe = "SEVERE"
    }
    
    private class func sourceFileName(filePath: String) -> String {
        let components = filePath.components(separatedBy: "/")
        guard let fileName = components.last else {
            return ""
        }
        return fileName
    }
    
    private init() {}
    
    // MARK:- Logging functions
    class func error(_ object: Any, fileName: String = #file, line: Int = #line, column: Int = #column, functionName: String = #function) {
        #if DEBUG
        let logStr = "\(Date().toString()) [\(LogEvent.error.rawValue)] [\(sourceFileName(filePath: fileName))]:\(line) \(column) \(functionName) -> \(object)"
        print(logStr)
        #endif
    }
    
    class func info(_ object: Any, fileName: String = #file, line: Int = #line, column: Int = #column, functionName: String = #function) {
        #if DEBUG
        let logStr = "\(Date().toString()) [\(LogEvent.info.rawValue)] [\(sourceFileName(filePath: fileName))]:\(line) \(column) \(functionName) -> \(object)"
        print(logStr)
        #endif
    }
    
    class func debug(_ object: Any, fileName: String = #file, line: Int = #line, column: Int = #column, functionName: String = #function) {
        #if DEBUG
        let logStr = "\(Date().toString()) [\(LogEvent.debug.rawValue)] [\(sourceFileName(filePath: fileName))]:\(line) \(column) \(functionName) -> \(object)"
        print(logStr)
        #endif
    }
    
    class func warn(_ object: Any, fileName: String = #file, line: Int = #line, column: Int = #column, functionName: String = #function) {
        #if DEBUG
        let logStr = "\(Date().toString()) [\(LogEvent.warn.rawValue)] [\(sourceFileName(filePath: fileName))]:\(line) \(column) \(functionName) -> \(object)"
        print(logStr)
        #endif
    }
    
    class func severe(_ object: Any, fileName: String = #file, line: Int = #line, column: Int = #column, functionName: String = #function) {
        #if DEBUG
        let logStr = "\(Date().toString()) [\(LogEvent.severe.rawValue)] [\(sourceFileName(filePath: fileName))]:\(line) \(column) \(functionName) -> \(object)"
        print(logStr)
        #endif
    }
}

extension Date {
    func toString() -> String {
        return Log.dateFormatter.string(from: self)
    }
}
