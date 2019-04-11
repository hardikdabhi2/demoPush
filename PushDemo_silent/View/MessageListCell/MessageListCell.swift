//
//  MessageListCell.swift
//  PushDemo_silent
//
//  Created by Hardik on 11/04/19.
//  Copyright © 2019 HardikDabhi. All rights reserved.
//

import UIKit

class MessageListCell: UITableViewCell {
    
    @IBOutlet weak var labelReceive:UILabel!
    @IBOutlet weak var labelSend:UILabel!
    @IBOutlet weak var viewSender:UIView!
    @IBOutlet weak var viewReceiver:UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
