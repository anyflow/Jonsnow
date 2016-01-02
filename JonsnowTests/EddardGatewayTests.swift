//
//  EddardGatewayTests.swift
//  Jonsnow
//
//  Created by Park Hyunjeong on 12/6/15.
//  Copyright © 2015 Anyflow. All rights reserved.
//


import XCTest
@testable import Jonsnow

class EddardGatewayTests: XCTestCase {
    let logger: Logger = Logger(className : EddardGatewayTests.self.description())

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testGetUsers() {
        let expectation = expectationWithDescription("Alamofire")
        EddardGateway.SELF.getUsers { users in
            
            self.logger.debug(users?[0].description)
            
            expectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(5.0, handler: nil)
    }
}