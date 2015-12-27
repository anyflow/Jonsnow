//
//  EddardGateway.swift
//  Jonsnow
//
//  Created by Park Hyunjeong on 12/6/15.
//  Copyright © 2015 Anyflow. All rights reserved.
//

import Foundation
import Alamofire

typealias ServiceResponse = (JSON, NSError?) -> Void

class EddardGateway {
    static let SELF: EddardGateway = EddardGateway()

    private let logger: Logger = Logger(className: "EddardGateway")
    
    private init() {
    }
    
    let baseUri : String = "http://192.168.0.5:8090"
    
    func register(device: Device?) {
        guard let device = device else {
            logger.error("device should not be nil")
            return
        }
        
        let request = NSMutableURLRequest(URL: NSURL(string: baseUri + "/device")!)
        
        request.HTTPMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.HTTPBody = (device.jsonString as NSString).dataUsingEncoding(NSUTF8StringEncoding)!
        
        
        Alamofire.request(request).response { response in
            if let code = response.1?.statusCode {
                self.logger.debug(response.1?.description)
            }
            else {
                self.logger.error(response.3?.description)
            }
            
        }
    }
    
    @noreturn
    func getUsers() -> [User] {
        
    }
    
    func testRegister(receiverId: String, onCompletion: (NSURLResponse?, JSON, NSError?) -> Void) {
        let semaphore = dispatch_semaphore_create(0)
        
        let request : NSMutableURLRequest = NSMutableURLRequest(URL: NSURL(string: "https://httpbin.org/get?foo=bar")!)
        request.HTTPMethod = "GET"
        
        let session = NSURLSession.sharedSession()
        
        
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            let json:JSON = JSON(data: data!)
            onCompletion(response, json, error)
            
            dispatch_semaphore_signal(semaphore)
        })
        
        task.resume()
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER)
    }
}