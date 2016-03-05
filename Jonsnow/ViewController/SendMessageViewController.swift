//
//  SendMessageViewController.swift
//  Jonsnow
//
//  Created by Park Hyunjeong on 1/17/16.
//  Copyright © 2016 Anyflow. All rights reserved.
//

import UIKit

class SendMessageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

	let logger: Logger = Logger(className: SendMessageViewController.self.description())

	var messages: [Message] = []
	var channel: Channel?
	var users: [User] = []

	@IBOutlet weak var bottomHeight: NSLayoutConstraint!

	@IBOutlet weak var textfieldMessage: UITextField!

	@IBOutlet weak var tableviewChat: UITableView!

	var refreshControl: UIRefreshControl = UIRefreshControl()

	override func viewDidLoad() {
		super.viewDidLoad()

		NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name: UIKeyboardWillShowNotification, object: nil)
		NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name: UIKeyboardWillHideNotification, object: nil)

		refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
		refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)

		tableviewChat.dataSource = self
		tableviewChat.autoresizingMask = .FlexibleHeight
		tableviewChat.addSubview(refreshControl)

		if users.count <= 0 { return; }

		users.append(Settings.SELF.myProfile!)

		EddardGateway.SELF.createChannel("Shoud be changed!!", inviteeIds: [users[0].id!], secretKey: "someSecretKey", completionHandler: { channel in
			guard let channel = channel else {
				// TOOD error handling
				return
			}

			self.channel = channel

			EddardGateway.SELF.channels.append(channel)

			channel.messageReceived = { message in
				self.logger.debug(message.text)

				self.messages += [message]

				EddardGateway.SELF.sendMesssageReceived(channel.id!, messageId: message.id!)

				self.tableviewChat.performSelectorOnMainThread(Selector("reloadData"), withObject: nil, waitUntilDone: true)
			}

			channel.unreadCountChanged = { messageId in
				let messages = self.messages.filter({ message in return message.id == messageId})

				if messages.count <= 0 { return }

				messages[0].unreadCount! -= 1

				self.tableviewChat.performSelectorOnMainThread(Selector("reloadData"), withObject: nil, waitUntilDone: true)
			}
		})
	}

	func refresh(sender: AnyObject) {
		guard let channelId = channel?.id else {
			return
		}

		self.messages.removeAll()

		EddardGateway.SELF.retrieveMessages(channelId, completionHandler: { messages -> Void in
			self.messages += messages

			self.tableviewChat.performSelectorOnMainThread(Selector("reloadData"), withObject: nil, waitUntilDone: true)
			self.refreshControl.performSelectorOnMainThread(Selector("endRefreshing"), withObject: nil, waitUntilDone: true)
		})
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	@IBAction func send(sender: UIButton) {
		guard let channel = channel else {
			logger.error("No channel created.")
			// TOOD error handling
			return
		}

		EddardGateway.SELF.createMessage(channel.id!, text: textfieldMessage.text!)
		textfieldMessage.text = ""
	}

	@IBAction func cancel(sender: UIBarButtonItem) {
		dismissViewControllerAnimated(true, completion: nil)
	}

	func keyboardWillShow(notification: NSNotification) {
		guard let userInfo = notification.userInfo else {
			return
		}

		guard let keyboardSize = (userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() else {
			return
		}

		bottomHeight.constant = keyboardSize.height
		view.setNeedsLayout()
	}

	func keyboardWillHide(notification: NSNotification) {
		bottomHeight.constant = 0.0
		view.setNeedsLayout()
	}

	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}

	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return messages.count
	}

	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("ChatCell", forIndexPath: indexPath) as! SendmessageTableViewCell

		let message = messages[indexPath.row] as Message
		let filteredUsers = users.filter({ user in
			return user.id == message.creatorId
		})

		cell.labelName.text = "\(filteredUsers[0].name!) | \(message.createDate!.dateStringWithFormat("yyyy - MM - dd HH: mm: ss"))"
		cell.labelSendDate.text = message.unreadCount!.description
		cell.textviewChat.text = message.text

		return cell
	}
}