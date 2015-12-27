//
//  Database.swift
//  Jonsnow
//
//  Created by Park Hyunjeong on 12/27/15.
//  Copyright © 2015 Anyflow. All rights reserved.
//

import Foundation
import RealmSwift

class Settings: Object {
    
    static let SELF : Settings = Settings()
    
    private let logger: Logger = Logger(className: "Settings")
    
    dynamic var deviceToken: String? {
        didSet {
            logger.debug("oldValue:\(oldValue) | newValue:\(deviceToken)")
        }
    }
    dynamic var deviceId: String? {
        didSet {
            logger.debug("oldValue:\(oldValue) | newValue:\(deviceId)")
        }
    }
    
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
            if let deviceId = db.deviceId {
                self.deviceId = deviceId
            }
        }
        else {
            self.logger.error("Data in Realm is nil")
        }
        
        if self.deviceId == nil {
            self.deviceId = NSUUID().UUIDString
        }
        
        logger.debug("device token : \(deviceToken)")
        logger.debug("device Id : \(deviceId)")
    }
}