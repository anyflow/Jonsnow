
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
import Starscream
import SwiftyJSON

class EddardGateway {
	static let SELF: EddardGateway = EddardGateway()

	private let logger: Logger = Logger(className: "EddardGateway")

	private init() {
		socket = WebSocket(url: NSURL(string: websocketScheme + baseUri + websocketPath)!, protocols: ["smp_v1.0"])

		socket.queue = dispatch_queue_create("com.lge.stark.Jonsnow", nil)
		socket.onConnect = connected
		socket.onDisconnect = disconnected
		socket.onText = textFrameReceived
		socket.onData = binaryFrameReceived
	}

	var socket : WebSocket

	let baseUri : String = "anyflow.iptime.org:8090"
	let httpScheme : String = "http://"
	let websocketScheme : String = "ws://"
	let websocketPath : String = "/websocket"

	var initializationLock = dispatch_semaphore_create(0)
	let timeout = dispatch_time(DISPATCH_TIME_NOW, 100 * 1000 * 1000)

	var sessionId: String?
	var heartbeatRateInSecond = -1

	var resGetFriendsHandler: ((users: Array<User>?) -> Void)?
	var resCreateChannelHandler: (Channel? -> Void)?
	var resCreateMessageHandler: (Message? -> Void)?
    var channels: [Channel] = []


	func connect() {
		if socket.isConnected || sessionId == nil {
			sessionId = nil;
			socket.disconnect();
		}

		socket.connect()

		// TODO replace DISPATCH_TIME_FOREVER
		dispatch_semaphore_wait(initializationLock, DISPATCH_TIME_FOREVER)
	}

	func connected() {
		logger.debug("connected!")

		let initialize = Smpframe.newJsonString(0, id: 0, sessionId: nil, fields: ["deviceId":Settings.SELF.deviceId, "networkType": Settings.SELF.networkType()])

		socket.writeString(initialize!)
	}

	func disconnected(error: NSError?) {
		sessionId = nil
	}

	func textFrameReceived(textFrame: String) {
        dispatch_semaphore_signal(initializationLock)
        
		logger.debug(textFrame)

		// TODO invalid text handling...

		let json = JSON(data: textFrame.dataUsingEncoding(NSUTF8StringEncoding)!);

		switch json["opcode"].int16Value {
		case 200:
			onReturnOk(textFrame)
		case 51:
			onSetHeartbeatRate(json["sessionId"].stringValue, heartbeatRateInSecond: json["heartbeatRate"].intValue)
		case 353:
			let users = Mapper<User>().mapArray(json["users"].rawString()!)
			onResGetFriends(users)
		case 354:
			let channel = Mapper<Channel>().map(json["channel"].rawString())
			onResCreateChannel(channel)
        case 355:
            let message = Mapper<Message>().map(json["message"].rawString())!
            onMessageCreated(message)
		case 160:
			onErrorStarkService(json["code"].stringValue, description: json["description"].rawString()!)
		default:
			logger.error("invalid smpframe! \(textFrame)")
		}
	}

    func onMessageCreated(message: Message) {
        for channel in channels {
            if(channel.id != message.channelId) { continue }
            
            if(channel.messageReceived == nil) { continue; }
            
            channel.messageReceived!(message: message)
            return
        }
    }
    
	func onErrorStarkService(code: String, description: String) {
		logger.debug("onErrorStarkService : \(code) | \(description)")

		// TODO onErrorStarkService
	}

	func onReturnOk(json: String) {
		logger.debug("Retured OK : \(json)")
	}

	func onResGetFriends(users: [User]?) {
		guard let handler = resGetFriendsHandler else {
			return;
		}

		handler(users: users)
		resGetFriendsHandler = nil
	}

	func onResCreateChannel(channel: Channel?) {
		guard let handler = resCreateChannelHandler else {
			return;
		}

		handler(channel)
		resCreateChannelHandler = nil
	}

	func onSetHeartbeatRate(sessionId: String, heartbeatRateInSecond: Int) {
		self.sessionId = sessionId
		self.heartbeatRateInSecond = heartbeatRateInSecond

		// TODO set heartbeatrate handing..


	}
    func sendMesssageReceived(channelId: String, messageId: String) {
        let request = Smpframe.newJsonString(307, id: 0, sessionId: sessionId!, fields: ["messageId": messageId])
        
        socket.writeString(request!)
    }
    
	func getFriends(completionHandler: ([User]? -> Void)) {
		if isConnected == false {
			logger.error("Session is not established!")
			return;
		}

		resGetFriendsHandler = completionHandler

		let request = Smpframe.newJsonString(303, id: 0, sessionId: sessionId!, fields: ["userId": Settings.SELF.userId])

		socket.writeString(request!)
	}

	func createChannel(name: String, inviteeIds: [String], secretKey: String, completionHandler: (Channel? -> Void)) {
		if isConnected == false {
			logger.error("Session is not established!")
			return;
		}

		resCreateChannelHandler = completionHandler

		let request = Smpframe.newJsonString(304, id: 0, sessionId: sessionId!, fields: ["name": name, "inviterId": Settings.SELF.userId, "inviteeIds": inviteeIds, "secretKey": secretKey])

		socket.writeString(request!)
	}

	func createMessage(channelId: String, text: String) {
		if isConnected == false {
			logger.error("Session is not established!")
			return;
		}

		let request = Smpframe.newJsonString(305, id: 0, sessionId: sessionId!, fields: ["channelId": channelId, "creatorId": Settings.SELF.userId, "text": text])

		socket.writeString(request!)
	}

	func binaryFrameReceived(data: NSData) {
	}

	func dispose() {
		socket.disconnect()
	}

	var isConnected: Bool {
		return socket.isConnected && sessionId != nil;
	}

	func register(device: Device?) {
		if isConnected == false {
			logger.error("Session is not established!")
			return;
		}

		guard let device = device else {
			logger.error("device should not be nil")
			return
		}

		let deviceMap = Mapper().toJSON(device)
		let request = Smpframe.newJsonString(300, id: 0, sessionId: sessionId!, fields: deviceMap)

		socket.writeString(request!)
	}
}