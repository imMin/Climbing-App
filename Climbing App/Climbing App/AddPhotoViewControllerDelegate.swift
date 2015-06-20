//
//  AddPhotoViewControllerDelegate.swift
//  Climbing App
//
//  Created by Melissa on 6/19/15.
//  Copyright (c) 2015 Min Hu. All rights reserved.
//

import UIKit

protocol AddPhotoViewControllerDelegate {
    func addPhotoViewControllerDidCancel(controller: AddPhotoViewController)
    
    func addViewControllerDidFinish(controller: AddPhotoViewController)
}

