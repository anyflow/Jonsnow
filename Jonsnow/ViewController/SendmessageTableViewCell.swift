//
//  SendmessageTableViewCell.swift
//  Jonsnow
//
//  Created by Park Hyunjeong on 1/17/16.
//  Copyright © 2016 Anyflow. All rights reserved.
//

import UIKit

class SendmessageTableViewCell: UITableViewCell {

    @IBOutlet weak var stackpanelContent: UIStackView!
	@IBOutlet weak var labelName: UILabel!
	@IBOutlet weak var textviewChat: UITextView!
	@IBOutlet weak var labelSendDate: UILabel!

	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
	}

	override func setSelected(selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)

		// Configure the view for the selected state
	}

    func setContent(userName: String, message: Message) {
        labelName.text = "\(userName) | \(message.createDate!.dateStringWithFormat("yyyy - MM - dd HH: mm: ss"))"
        labelSendDate.text = message.unreadCount!.description
        textviewChat.text = message.text
        
        resize()
    }
    
	private func resize() {
		var frame = CGRect();

		frame = stackpanelContent.frame;
		frame.size.height = textviewChat.contentSize.height;
		stackpanelContent.frame = frame;
	}
}
