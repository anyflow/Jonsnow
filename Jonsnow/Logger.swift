//
//  Logger.swift
//  Jonsnow
//
//  Created by Park Hyunjeong on 12/14/15.
//  Copyright © 2015 Anyflow. All rights reserved.
//

import Foundation

class Logger {

    private let className: String
    
    init(className: String) {
        self.className = className
    }
    
    private func log(type: String, message: String?, function: String, line: Int) {
        
        let msg: String = message == nil ? "null" : message!
        
        NSLog("\(type) [\(className).\(function):\(line)] \(msg)")
    }
    
    func debug(message: String?, function: String = __FUNCTION__, line: Int = __LINE__) {
        log("DEBUG", message: message, function: function, line: line)
    }
    
    func warn(message: String?, function: String = __FUNCTION__, line: Int = __LINE__) {
        log("WARN ", message: message, function: function, line: line)
    }
    
    func info(message: String?, function: String = __FUNCTION__, line: Int = __LINE__) {
        log("INFO ", message: message, function: function, line: line)
    }
    
    func error(message: String?, function: String = __FUNCTION__, line: Int = __LINE__) {
        log("ERROR", message: message, function: function, line: line)
    }

}