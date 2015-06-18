//
//  AddPhotoViewController.swift
//  Climbing App
//
//  Created by Min Hu on 6/17/15.
//  Copyright (c) 2015 Min Hu. All rights reserved.
//

import UIKit

var cameraView: CameraSessionView!

class AddPhotoViewController: UIViewController, CACameraSessionDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cameraView = CameraSessionView(frame: self.view.frame)
        cameraView.delegate = self
        view.addSubview(cameraView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didCaptureImage(image: UIImage!) {
        //use the image that is received
    }
    
    func didCaptureImageWithData(imageData: NSData!) {
        //use the image's data that is received
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
