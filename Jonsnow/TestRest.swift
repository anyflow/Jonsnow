//
//  TestRest.swift
//  Jonsnow
//
//  Created by Park Hyunjeong on 2/14/16.
//  Copyright © 2016 Anyflow. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class TestRest {
    static let SELF: TestRest = TestRest()
    
    private let logger: Logger = Logger(className: "TestRest")
    
    private init() {
    }
    
    let baseUri : String = "192.168.0.9:8090"
    let httpScheme : String = "http://"

    func register(device: Device?) {
        guard let device = device else {
            logger.error("device should not be nil")
            return
        }
        
        let request = NSMutableURLRequest(URL: NSURL(string: httpScheme + baseUri + "/device")!)
        
        request.HTTPMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.HTTPBody = (device.jsonString as NSString).dataUsingEncoding(NSUTF8StringEncoding)!
        
        Alamofire.request(request).response { response in
            if let _ = response.1?.statusCode {
                self.logger.debug(response.1?.description)
            }
            else {
                self.logger.error(response.3?.description)
            }
        }
    }
    
    func getUsers(completionHandler: ([User]? -> Void)?) {
        let userId = Settings.SELF.userId;
        
        Alamofire.request(.GET, "\(httpScheme + baseUri)/user/\(userId)/friend").responseString { response in
            
            if let json = response.result.value {
                if let users: Array<User> = Mapper<User>().mapArray(json) {
                    self.logger.debug(users[0].description)
                    
                    completionHandler?(users)
                }
                else {
                    self.logger.debug("nil!!")
                    
                    completionHandler?(nil)
                }
            }
            else {
                completionHandler?(nil)
            }
        }
    }
}