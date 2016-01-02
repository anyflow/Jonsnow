//
//  EddardGateway.swift
//  Jonsnow
//
//  Created by Park Hyunjeong on 12/6/15.
//  Copyright © 2015 Anyflow. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

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
        
        Alamofire.request(.GET, "\(baseUri)/user/\(userId)/friend").responseString { response in

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