//
//  RouteDetailViewController.swift
//  Climbing App
//
//  Created by Min Hu on 6/16/15.
//  Copyright (c) 2015 Min Hu. All rights reserved.
//

import UIKit

class RouteDetailViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
	
	var routeName: String!
	var level: String!
	var type: String!
	var distance: String!
	var climb: String!
	
    let picker = UIImagePickerController()
	
	@IBOutlet weak var routeNameLabel: UILabel!
	@IBOutlet weak var levelLabel: UILabel!
	@IBOutlet weak var typeLabel: UILabel!
	@IBOutlet weak var distanceLabel: UILabel!
	@IBOutlet weak var climbLabel: UILabel!
	
    var hasNewPhoto: Bool!
    var newPhoto: UIImage!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		routeNameLabel.text = routeName
		levelLabel.text = level
		typeLabel.text = type
		distanceLabel.text = distance
		climbLabel.text = climb
        
        picker.delegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Delegates
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        var chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //2
//        myImageView.contentMode = .ScaleAspectFit //3
//        myImageView.image = chosenImage //4
//        dismissViewControllerAnimated(true, completion: nil) //5
        

        var editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        var metaData = UIImagePickerControllerMediaMetadata as String

   
    }
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
        
    }

	@IBAction func didPressBackButton(sender: AnyObject) {
		navigationController?.popViewControllerAnimated(true)
		
	}

    @IBAction func didPressAddPhoto(sender: AnyObject) {
//        if UIImagePickerController.availableCaptureModesForCameraDevice(.Rear) != nil {
//            picker.allowsEditing = false
//            picker.sourceType = UIImagePickerControllerSourceType.Camera
//            picker.cameraCaptureMode = .Photo
//            presentViewController(picker, animated: true, completion: nil)
//        } else {
//            noCamera()
//        }

        performSegueWithIdentifier("addPhotoSegue", sender: nil)
        
    }
    func noCamera(){
        let alertVC = UIAlertController(title: "No Camera", message: "Sorry, this device has no camera", preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "OK", style:.Default, handler: nil)
        alertVC.addAction(okAction)
        presentViewController(alertVC, animated: true, completion: nil)
    }
    
    
//    @IBAction func didPressChoosePhoto(sender: AnyObject) {
//        picker.allowsEditing = false //2
//        picker.sourceType = .PhotoLibrary //3
//        
//        picker.modalPresentationStyle = .Popover
//        presentViewController(picker, animated: true, completion: nil)//4
//    }
    
}
