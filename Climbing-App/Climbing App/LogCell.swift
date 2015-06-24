//
//  LogCell.swift
//  Climbing App
//
//  Created by Min Hu on 6/14/15.
//  Copyright (c) 2015 Min Hu. All rights reserved.
//

import UIKit

class LogCell: UITableViewCell {

	@IBOutlet weak var levelLabel: UILabel!
	@IBOutlet weak var locationLabel: UILabel!
	@IBOutlet weak var styleLabel: UILabel!
	@IBOutlet weak var typeLabel: UILabel!
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
