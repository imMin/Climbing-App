//
//  AddPhotoViewController.swift
//  Climbing App
//
//  Created by Min Hu on 6/17/15.
//  Copyright (c) 2015 Min Hu. All rights reserved.
//

import UIKit

class AddPhotoViewController: UIViewController, TGCameraDelegate {
    
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var captionTextView: UITextView!
    var navController: TGCameraNavigationController!
    var triggerOpen: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()


        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        if triggerOpen == true {
        navController = TGCameraNavigationController.newWithCameraDelegate(self)
        exposeCamera()
            triggerOpen = false
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func exposeCamera() {
        self.presentViewController(navController, animated: true, completion: nil)
    }
    
    func cameraWillTakePhoto() {
        
    }
    
    func cameraDidSavePhotoAtPath(assetURL: NSURL!) {
            //when implemented, an image will be saved on user's device
    }
    
    func cameraDidCancel() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    func cameraDidTakePhoto(image: UIImage!) {
        photoView.image = image
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func cameraDidSelectAlbumPhoto(image: UIImage!) {
        photoView.image = image
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func didPressBack(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
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
