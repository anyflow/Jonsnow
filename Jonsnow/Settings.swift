//
//  Database.swift
//  Jonsnow
//
//  Created by Park Hyunjeong on 12/27/15.
//  Copyright © 2015 Anyflow. All rights reserved.
//

import Foundation
import RealmSwift
import UIKit

class Settings: Object {
    
    static let SELF : Settings = Settings()
    
    private let logger: Logger = Logger(className: "Settings")
    
    dynamic var deviceToken: String? {
        didSet {
            logger.debug("oldValue:\(oldValue) | newValue:\(deviceToken)")
        }
    }
    
    var deviceId: String = UIDevice.currentDevice().identifierForVendor!.UUIDString
    let userId:String = "37cd2cd5-0a1e-4641-9f5e-6096b16b64d5"

    
    required init() {
        super.init()
    
        load()
    }
    
    func save() {
        do {
            try realm?.write {
                realm!.add(self, update: true)
            }
        }
        catch let error as NSError {
            logger.error(error.description)
        }
        
        logger.debug("Settings saved.")
    }
    
    private func load() {

        if let db = self.realm?.objects(Settings).first {
            if let deviceToken = db.deviceToken {
                self.deviceToken = deviceToken
            }
        }
        else {
            self.logger.error("Data in Realm is nil")
        }
        
        logger.debug("device token : \(deviceToken)")
        logger.debug("device id : \(deviceId)")
    }
}