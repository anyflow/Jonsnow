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
    
    var chats: [Chat] = []
    
    @IBOutlet weak var bottomHeight: NSLayoutConstraint!

    @IBOutlet weak var textfieldMessage: UITextField!
    
    @IBOutlet weak var tableviewChat: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name: UIKeyboardWillHideNotification, object: nil)
        
//        tableviewChat.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: "ChatCell")
        tableviewChat.dataSource = self
        tableviewChat.autoresizingMask = .FlexibleHeight
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func send(sender: UIButton) {
        let chat = Chat()
        
        chat.creatorId = "testId"
        chat.message = textfieldMessage.text
        chat.createDate = NSDate()
        
        logger.debug(chat.message)
        
        chats += [chat]
        
        tableviewChat.reloadData()
        
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
        return chats.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ChatCell", forIndexPath: indexPath) as! SendmessageTableViewCell

        let chat = chats[indexPath.row] as Chat
        cell.labelName.text = chat.creatorId
        cell.labelSendDate.text = chat.createDate?.description
        cell.textviewChat.text = chat.message
        
        return cell
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}