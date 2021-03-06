//
//  AddPhotoViewController.swift
//  Climbing App
//
//  Created by Min Hu on 6/17/15.
//  Copyright (c) 2015 Min Hu. All rights reserved.
//

import UIKit

protocol AddPhotoViewControllerDelegate {
    func passImage(controller: AddPhotoViewController, image: UIImage, string: String)
}


class AddPhotoViewController: UIViewController, TGCameraDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var captionTextView: UITextView!
    var navController: TGCameraNavigationController!
    var triggerOpen: Bool = true
    
    @IBOutlet weak var captionTextField: UITextField?
    var delegate: AddPhotoViewControllerDelegate? = nil
    
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
        
//        if (delegate != nil) {
//            println("passing image to delegate")
//            delegate?.passImage(self, image: TGAlbum.imageWithMediaInfo(info))
//        }

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
//        if (delegate != nil) {
//            delegate?.passImage(self, image: image)
//        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func cameraDidSelectAlbumPhoto(image: UIImage!) {
        println("did select album photo")
        photoView.image = image
//        if (delegate != nil) {
//            println("passing image to delegate")
//            delegate?.passImage(self, image: image)
//        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func didPressSubmit(sender: AnyObject) {
        if (delegate != nil) {
            println("passing image to delegate")
            delegate?.passImage(self, image: photoView.image!, string: captionTextField!.text)
        }

//        self.delegate!.addViewControllerDidFinish(self)
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func didPressCancel(sender: AnyObject) {
        println("did Press Cancel")
        dismissViewControllerAnimated(true, completion: nil)
        
//        self.delegate!.addPhotoViewControllerDidCancel(self)

    }
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        println("calling prepareForSegue")
//        var viewController = segue.destinationViewController as! RouteDetailViewController
//        
//        viewController.hasNewPhoto = true
//        viewController.newPhoto = photoView.image
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
