//
//  RouteDetailViewController.swift
//  Climbing App
//
//  Created by Min Hu on 6/16/15.
//  Copyright (c) 2015 Min Hu. All rights reserved.
//

import UIKit


class RouteDetailViewController: UIViewController, NYTPhotosViewControllerDelegate, AddPhotoViewControllerDelegate, UIScrollViewDelegate {
	
	var routeName: String!
	var level: String!
	var type: String!
	var distance: String!
	var climb: String!
	
    let picker = UIImagePickerController()
	
    @IBOutlet weak var routeLabel: UILabel!
	@IBOutlet weak var routeNameLabel: UILabel!
	@IBOutlet weak var levelLabel: UILabel!
	@IBOutlet weak var typeLabel: UILabel!
	@IBOutlet weak var distanceLabel: UILabel!
	@IBOutlet weak var climbLabel: UILabel!
	@IBOutlet weak var videoView: YTPlayerView!
	@IBOutlet weak var commentBar: UIView!
	@IBOutlet weak var bottomConstraint: NSLayoutConstraint!
	@IBOutlet weak var commentField: UITextField!
	
    @IBOutlet weak var scrollView: UIScrollView!
    var hasNewPhoto: Bool = false
    var newPhoto: UIImage!
    var newPhotoCaption: String!
    @IBOutlet weak var imageButton: UIButton!
    let photos = PhotosProvider().photos
    
    @IBOutlet weak var climbingPhotosView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
		routeLabel.text = routeName
		levelLabel.text = level
		typeLabel.text = type
//		distanceLabel.text = distance
//		climbLabel.text = climb
        
        let buttonImage = UIImage(named: PrimaryImageName)
        imageButton?.setBackgroundImage(buttonImage, forState: .Normal)

		
		self.view.frame.size = CGSizeMake(320, 568)
		
		scrollView.frame.size = CGSizeMake(320, 568)
		
        // Do any additional setup after loading the view.
        scrollView.contentSize = CGSizeMake(320, 3450)
		scrollView.delegate = self
		
		
//        if hasNewPhoto == true {
//            addNewPhoto()
//        }
		
		videoView.loadWithVideoId("KZ8UsvygtNE", playerVars: ["playsinline" : 1, "modestbranding" : 0, "showinfo" : 0, "controls" : 1, "fs" : 1, "autohide" : 1])
		
		NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: nil);
		NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil);
		
		commentField.addTarget(commentField, action: "resignFirstResponder", forControlEvents: UIControlEvents.EditingDidEndOnExit)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addNewPhoto() {
		let photoHeight = self.imageButton.frame.height + 10
		
		self.imageButton.frame.origin = videoView.frame.origin
		
//		scrollView.contentSize = CGSizeMake(scrollView.contentSize.width, scrollView.contentSize.height + photoHeight)
		
        UIView.animateWithDuration(0.7, animations: { () -> Void in
			self.videoView.frame.origin.y += photoHeight
//            self.climbingPhotosView.frame.origin.y += photoHeight
			self.scrollView.contentOffset = self.imageButton.frame.origin
        })
        
        //TODO: add new photo to carousel

		
    }

	@IBAction func didPressBackButton(sender: AnyObject) {
		navigationController?.popViewControllerAnimated(true)
		
	}

    @IBAction func didPressAddPhoto(sender: AnyObject) {
        performSegueWithIdentifier("addPhotoSegue", sender: nil)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "addPhotoSegue" {
            let vc = segue.destinationViewController as! AddPhotoViewController
//            vc.photoView.image = newPhoto
            vc.delegate = self
        }
    }
    
    func noCamera(){
        let alertVC = UIAlertController(title: "No Camera", message: "Sorry, this device has no camera", preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "OK", style:.Default, handler: nil)
        alertVC.addAction(okAction)
        presentViewController(alertVC, animated: true, completion: nil)
    }
    
    @IBAction func didTapImageButton(sender: AnyObject) {
        let photosViewController = NYTPhotosViewController(photos: self.photos)
        photosViewController.delegate = self
        presentViewController(photosViewController, animated: true, completion: nil)
        
        updateImagesOnPhotosViewController(photosViewController, afterDelayWithPhotos: photos)

    }
    
    func updateImagesOnPhotosViewController(photosViewController: NYTPhotosViewController, afterDelayWithPhotos: [ExamplePhoto]) {
        
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, 5 * Int64(NSEC_PER_SEC))
        
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            for photo in self.photos {
                if photo.image == nil {
                    photo.image = UIImage(named: PrimaryImageName)
                    photosViewController.updateImageForPhoto(photo)
                }
            }
        }
    }
    
    
    // MARK: - NYTPhotosViewControllerDelegate
    
    func photosViewController(photosViewController: NYTPhotosViewController!, handleActionButtonTappedForPhoto photo: NYTPhoto!) -> Bool {
        
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            
            let shareActivityViewController = UIActivityViewController(activityItems: [photo.image], applicationActivities: nil)
            
            shareActivityViewController.completionWithItemsHandler = {(activityType: String!, completed: Bool, items: [AnyObject]!, NSError) in
                if completed {
                    photosViewController.delegate?.photosViewController!(photosViewController, actionCompletedWithActivityType: activityType)
                }
            }
            
            shareActivityViewController.popoverPresentationController?.barButtonItem = photosViewController.rightBarButtonItem
            photosViewController.presentViewController(shareActivityViewController, animated: true, completion: nil)
            
            return true
        }
        
        return false
    }
    
//    func photosViewController(photosViewController: NYTPhotosViewController!, referenceViewForPhoto photo: NYTPhoto!) -> UIView! {
//        if photo as? ExamplePhoto == photos[NoReferenceViewPhotoIndex] {
//            /** Swift 1.2
//            *  if photo as! ExamplePhoto == photos[PhotosProvider.NoReferenceViewPhotoIndex]
//            */
//            return nil
//        }
//        return imageButton
//    }
//    
//    func photosViewController(photosViewController: NYTPhotosViewController!, loadingViewForPhoto photo: NYTPhoto!) -> UIView! {
//        if photo as! ExamplePhoto == photos[CustomEverythingPhotoIndex] {
//            /** Swift 1.2
//            *  if photo as! ExamplePhoto == photos[PhotosProvider.CustomEverythingPhotoIndex]
//            */
//            var label = UILabel()
//            label.text = "Custom Loading..."
//            label.textColor = UIColor.greenColor()
//            return label
//        }
//        return nil
//    }
    
//    func photosViewController(photosViewController: NYTPhotosViewController!, captionViewForPhoto photo: NYTPhoto!) -> UIView! {
//        if photo as! ExamplePhoto == photos[CustomEverythingPhotoIndex] {
//            /** Swift 1.2
//            *  if photo as! ExamplePhoto == photos[PhotosProvider.CustomEverythingPhotoIndex]
//            */
//            var label = UILabel()
//            label.text = "Custom Caption View"
//            label.textColor = UIColor.whiteColor()
//            label.backgroundColor = UIColor.redColor()
//            return label
//        }
//        return nil
//    }
    
    func photosViewController(photosViewController: NYTPhotosViewController!, didNavigateToPhoto photo: NYTPhoto!, atIndex photoIndex: UInt) {
        println("Did Navigate To Photo: \(photo) identifier: \(photoIndex)")
    }
    
    func photosViewController(photosViewController: NYTPhotosViewController!, actionCompletedWithActivityType activityType: String!) {
        println("Action Completed With Activity Type: \(activityType)")
    }
    
    func photosViewControllerDidDismiss(photosViewController: NYTPhotosViewController!) {
        println("Did dismiss Photo Viewer: \(photosViewController)")
    }

    func passImage(controller: AddPhotoViewController, image: UIImage, string: String) {
        newPhoto = image
        newPhotoCaption = string
        imageButton.setBackgroundImage(newPhoto, forState: UIControlState.Normal)
        addNewPhoto()
    }
	
	
	func keyboardWillShow(sender: NSNotification) {
		var info = sender.userInfo!
		var keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
		
		UIView.animateWithDuration(0.5, animations: { () -> Void in
			self.bottomConstraint.constant = keyboardFrame.size.height - 60
		})
	}
	
	func keyboardWillHide(sender: NSNotification) {
		UIView.animateWithDuration(0.5, animations: { () -> Void in
			self.bottomConstraint.constant = -8
		})
	}
	
    
	@IBAction func onTap(sender: AnyObject) {
		commentField.endEditing(true)
	}
}
