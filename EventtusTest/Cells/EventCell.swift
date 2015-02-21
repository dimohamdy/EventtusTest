//
//  EventCell.swift
//  EventtusTest
//
//  Created by binaryboy on 2/16/15.
//  Copyright (c) 2015 AhmedHamdy. All rights reserved.
//

import UIKit

class EventCell: UITableViewCell {

    @IBOutlet var coverImage: UIImageView!
    @IBOutlet var name: UILabel!
    @IBOutlet var startDate: UILabel!
    @IBOutlet var eventImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
