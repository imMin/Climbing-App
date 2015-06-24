//
//  RegionCell.swift
//  
//
//  Created by Min Hu on 6/15/15.
//
//

import UIKit

class RegionCell: UICollectionViewCell {
	
	@IBOutlet weak var regionNameLabel: UILabel!
	@IBOutlet weak var climbNumberLabel: UILabel!
	@IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var regionView: UIImageView!
    @IBOutlet weak var regionCellContent: UIView!
	
	
    var region: Region?
}
