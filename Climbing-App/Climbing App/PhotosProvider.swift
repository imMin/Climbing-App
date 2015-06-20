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
let CustomEverythingPhotoIndex = 1, DefaultLoadingSpinnerPhotoIndex = 3, NoReferenceViewPhotoIndex = 4
let PrimaryImageName = "climbing0"
let PlaceholderImageName = "climbing1"

class PhotosProvider: NSObject {
    
    let photos: [ExamplePhoto] = {
        
        var mutablePhotos: [ExamplePhoto] = []
        var image = UIImage(named: PrimaryImageName)
        let NumberOfPhotos = 5
        
        func shouldSetImageOnIndex(photoIndex: Int) -> Bool {
            return photoIndex != CustomEverythingPhotoIndex && photoIndex != DefaultLoadingSpinnerPhotoIndex
        }
        
        for photoIndex in 0 ..< NumberOfPhotos {
            let title = NSAttributedString(string: "\(photoIndex + 1)", attributes: [NSForegroundColorAttributeName: UIColor.whiteColor()])
            let photo = shouldSetImageOnIndex(photoIndex) ? ExamplePhoto(image: image, attributedCaptionTitle: title) : ExamplePhoto(attributedCaptionTitle: title)
            
            if photoIndex == CustomEverythingPhotoIndex {
                photo.placeholderImage = UIImage(named: PlaceholderImageName)
            }
            
            mutablePhotos.append(photo)
        }
        
        return mutablePhotos
        }()
}
