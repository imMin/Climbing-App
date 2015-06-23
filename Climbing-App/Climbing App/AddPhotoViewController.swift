//
//  AddPhotoViewController.swift
//  Climbing App
//
//  Created by Min Hu on 6/17/15.
//  Copyright (c) 2015 Min Hu. All rights reserved.
//

import UIKit

class AddPhotoViewController: UIViewController, TGCameraDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var captionTextView: UITextView!
    var navController: TGCameraNavigationController!
    var triggerOpen: Bool = true
    
//    var delegate: AddPhotoViewControllerDelegate?
    
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
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            self.presentViewController(navController, animated: true, completion: nil)
            return
        } else {
            var pickerController = TGAlbum.imagePickerControllerWithDelegate(self)
            self.presentViewController(pickerController, animated: true, completion: nil)
            
        }
        
    }
    
    func cameraWillTakePhoto() {


    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        photoView.image = TGAlbum.imageWithMediaInfo(info)
        self.dismissViewControllerAnimated(true, completion: nil)

    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(false, completion: nil)
        self.dismissViewControllerAnimated(true, completion: nil)
//        self.delegate!.addPhotoViewControllerDidCancel(self)

    }
    
    func cameraDidSavePhotoAtPath(assetURL: NSURL!) {
            //when implemented, an image will be saved on user's device
        
    }
    
    func cameraDidCancel() {
        self.dismissViewControllerAnimated(false, completion: nil)
        self.dismissViewControllerAnimated(true, completion: nil)

//        self.delegate!.addPhotoViewControllerDidCancel(self)
        
    }

    func cameraDidTakePhoto(image: UIImage!) {
        photoView.image = image
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func cameraDidSelectAlbumPhoto(image: UIImage!) {
        photoView.image = image
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func didPressSubmit(sender: AnyObject) {

//        self.delegate!.addViewControllerDidFinish(self)
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func didPressCancel(sender: AnyObject) {
        println("did Press Cancel")
        dismissViewControllerAnimated(true, completion: nil)
        
//        self.delegate!.addPhotoViewControllerDidCancel(self)

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        println("calling prepareForSegue")
        var viewController = segue.destinationViewController as! RouteDetailViewController
        
        viewController.hasNewPhoto = true
        viewController.newPhoto = photoView.image
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
