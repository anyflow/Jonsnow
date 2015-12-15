//
//  EddardGateway.swift
//  Jonsnow
//
//  Created by Park Hyunjeong on 12/6/15.
//  Copyright © 2015 Anyflow. All rights reserved.
//

import Foundation

typealias ServiceResponse = (JSON, NSError?) -> Void

class EddardGateway {
    static let SELF: EddardGateway = EddardGateway()

    private let logger: Logger = Logger(className: "EddardGateway")
    
    private init() {
    }
    
    var deviceToken: String! {
        didSet {
            register(deviceToken, onCompletion: { response, json, error in
                print(response?.description)
                print(json)
                print(error)
            })
            
            logger.debug(deviceToken)
        }
    }
    
    let baseUri : String = "http://localhost:8080"
    
    func register(receiverId: String, onCompletion: (NSURLResponse?, JSON, NSError?) -> Void) {
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
    
    @noreturn
    func getUsers() -> [User] {
        
    }
}