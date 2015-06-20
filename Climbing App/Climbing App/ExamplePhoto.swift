//
//  ExamplePhoto.swift
//  Climbing App
//
//  Created by Melissa on 6/19/15.
//  Copyright (c) 2015 Min Hu. All rights reserved.
//

import UIKit

class ExamplePhoto: NSObject, NYTPhoto {
    
    var image: UIImage?
    var placeholderImage: UIImage?
    let attributedCaptionTitle: NSAttributedString
    let attributedCaptionSummary = NSAttributedString(string: "summary string", attributes: [NSForegroundColorAttributeName: UIColor.grayColor()])
    let attributedCaptionCredit = NSAttributedString(string: "credit", attributes: [NSForegroundColorAttributeName: UIColor.darkGrayColor()])
    
    init(image: UIImage?, attributedCaptionTitle: NSAttributedString) {
        self.image = image
        self.attributedCaptionTitle = attributedCaptionTitle
        super.init()
    }
    
    convenience init(attributedCaptionTitle: NSAttributedString) {
        self.init(image: nil, attributedCaptionTitle: attributedCaptionTitle)
    }
    
}