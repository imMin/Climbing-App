//
//  SelectRouteCell.swift
//  Climbing App
//
//  Created by Min Hu on 6/17/15.
//  Copyright (c) 2015 Min Hu. All rights reserved.
//

import UIKit

class SelectRouteCell: UITableViewCell {
	
	@IBOutlet weak var cragNameLabel: UILabel!
	
	@IBOutlet weak var climbNumberLabel: UILabel!

	@IBOutlet weak var cragDistanceLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
