//
//  FriendTableViewController.swift
//  Jonsnow
//
//  Created by Park Hyunjeong on 12/15/15.
//  Copyright © 2015 Anyflow. All rights reserved.
//

import UIKit

class FriendTableViewController: UITableViewController {

	let logger: Logger = Logger(className: FriendTableViewController.self.description())

	var users: [User] = []

	override func viewDidLoad() {
		super.viewDidLoad()

		self.clearsSelectionOnViewWillAppear = false
		self.navigationItem.leftBarButtonItem = self.editButtonItem()
		self.navigationItem.leftBarButtonItem?.tintColor = UIColor.whiteColor()
        
        listFriends()
	}

	func listFriends() {
		EddardGateway.SELF.getFriends { users in
			guard let users = users else {
				return
			}

			for user in users {
				self.logger.debug(user.description)
			}

			self.users.appendContentsOf(users)

			self.tableView.performSelectorOnMainThread(Selector("reloadData"), withObject: nil, waitUntilDone: true)
		}
	}
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	// MARK: - Table view data source

	override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}

	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return users.count
	}

	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("FriendCell", forIndexPath: indexPath)

		let user = users[indexPath.row] as User
		cell.textLabel?.text = user.name
		cell.detailTextLabel?.text = user.department

		return cell
	}

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        guard let selectedRow = self.tableView.indexPathForSelectedRow else {
            return;
        }
        
        let selectedUser = users[selectedRow.row]
    
        let target = (segue.destinationViewController as! UINavigationController).topViewController as! SendMessageViewController
        target.users.append(selectedUser)
    }

	/*
	 // Override to support conditional editing of the table view.
	 override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
	 // Return false if you do not want the specified item to be editable.
	 return true
	 }
	 */

	/*
	 // Override to support editing the table view.
	 override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
	 if editingStyle == .Delete {
	 // Delete the row from the data source
	 tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
	 } else if editingStyle == .Insert {
	 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
	 }
	 }
	 */

	/*
	 // Override to support rearranging the table view.
	 override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

	 }
	 */

	/*
	 // Override to support conditional rearranging of the table view.
	 override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
	 // Return false if you do not want the item to be re-orderable.
	 return true
	 }
	 */


}
