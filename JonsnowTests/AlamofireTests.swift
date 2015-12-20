//
//  AlamofireTest.swift
//  Jonsnow
//
//  Created by Park Hyunjeong on 12/17/15.
//  Copyright © 2015 Anyflow. All rights reserved.
//

import XCTest
import Alamofire
@testable import Jonsnow

class AlamoFireTests: XCTestCase {
    let logger: Logger = Logger(className : AlamoFireTests.self.description())
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGet() {
//        let semaphore = dispatch_semaphore_create(0)
//
//        Alamofire.request(.GET, "https://httpbin.org/get", parameters: ["foo": "bar"])
//            .responseString { response in
//                self.logger.debug(response.description)
//                
//                dispatch_semaphore_signal(semaphore)
//        }
//        
//        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER)
    }
}