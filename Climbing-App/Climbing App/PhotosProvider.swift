//
//  PhotosProvider.swift
//  Climbing App
//
//  Created by Melissa on 6/19/15.
//  Copyright (c) 2015 Min Hu. All rights reserved.
//

import UIKit

/**
*   In Swift 1.2, the following file level constants can be moved inside the class for better encapsulation
*/
let PrimaryImageName = "climbing0"
var images = ["climbing0", "climbing1", "climbing2", "climbing3", "climbing4"]
var credits = ["Castle Rock State Park", "Castle Rock State Park", "Castle Rock State Park", "Castle Rock State Park", "Castle Rock State Park"]
var summaries = ["Shannon climbs Vicious Circles", "Pretty rocks", "Top rope climb 5.10b", "Beautiful day to climb", "Indian Rock, 5.11c"]
var titles = ["Jun 2015", "Oct 2014", "Oct 2014", "Jan 2015", "Mar 2015"]
//let captions = ["Mike Arechiga", "Bruce Willey", "James Morris", "Liz Langley", "Kristine Hoffman "]
var photos: [ExamplePhoto] = [ExamplePhoto]()

//TODO: Automatically pull in user identity and insert in credit

class PhotosProvider: NSObject {
    
    
    let photos: [ExamplePhoto] = {
        
        var mutablePhotos: [ExamplePhoto] = []
        for photoIndex in 0 ..< images.count {
            let image = UIImage(named: images[photoIndex])
            let summary = NSAttributedString(string: summaries[photoIndex], attributes: [NSForegroundColorAttributeName: UIColor.grayColor()])
            let credit = NSAttributedString(string: credits[photoIndex], attributes: [NSForegroundColorAttributeName: UIColor.darkGrayColor()])
            let title = NSAttributedString(string: titles[photoIndex], attributes: [NSForegroundColorAttributeName: UIColor.whiteColor()])
            let photo = ExamplePhoto(image: image, attributedCaptionTitle: title, attributedCaptionSummary: summary, attributedCaptionCredit: credit)
            mutablePhotos.append(photo)
        }
        return mutablePhotos
        }()
    
    
}

//func addPhoto(image: UIImage, caption: String) {
//    
//    let creditString = "Castle Rock State Park"
//    let credit = NSAttributedString(string: creditString, attributes: [NSForegroundColorAttributeName: UIColor.darkGrayColor()])
//    credits.append(creditString)
//    
//    let summary = NSAttributedString(string: caption, attributes: [NSForegroundColorAttributeName: UIColor.grayColor()])
//    summaries.append(caption)
//    
//    let titleString = "June 2015"
//    let title = NSAttributedString(string: titleString, attributes: [NSForegroundColorAttributeName: UIColor.grayColor()])
//    titles.append(titleString)
//    
//    //        let photo = ExamplePhoto(image: image, attributedCaptionTitle: title, attributedCaptionSummary: summary, attributedCaptionCredit: credit)
//    
//    
//}
