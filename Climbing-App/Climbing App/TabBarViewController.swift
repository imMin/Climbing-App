

//
//  TabBarViewController.swift
//  Climbing App
//
//  Created by Min Hu on 6/12/15.
//  Copyright (c) 2015 Min Hu. All rights reserved.


import UIKit

class TabBarViewController: UIViewController, UIViewControllerTransitioningDelegate {

	@IBOutlet weak var myLogButton: UIButton!
	@IBOutlet weak var browseButton: UIButton!
	@IBOutlet weak var addButton: UIButton!
	@IBOutlet weak var savedButton: UIButton!
	@IBOutlet weak var connectButton: UIButton!
	@IBOutlet weak var contentView: UIView!
	@IBOutlet weak var fiveButton: UIButton!
	@IBOutlet weak var vButton: UIButton!
	
    @IBOutlet weak var myLogLabel: UILabel!
    @IBOutlet weak var browseLabel: UILabel!
    @IBOutlet weak var forumLabel: UILabel!
    @IBOutlet weak var savedLabel: UILabel!
	@IBOutlet weak var backgroundView: UIView!
	
    @IBOutlet weak var addClimbLabel: UILabel!
    var flyoutOpen: Bool! = false
    
	var myLogViewController: UIViewController!
	var browseViewController: UIViewController!
	var addViewController: UIViewController!
	var savedViewController: UIViewController!
	var connectViewController: UIViewController!
	var selectedButton: UIButton!
    var selectedLabel: UILabel!
	var selectedViewController: UIViewController!
	var viewControllers: [UIViewController]!
	var buttons: [UIButton]!
	var startingPoint: CGFloat!
	var fiveButtonFinalPosition = CGPointMake(115, 460)
	var vButtonFinalPosition = CGPointMake(205, 460)
    var addClimbLabelFinalPosition = CGPointMake(160, 408)
    var addClimbLabelInitialPosition = CGPointMake(160, 700)
	var buttonsInitialPosition : CGPoint!

	let transition = addTransition()
    var labels: [UILabel]!
    
    let redColor = UIColor(red: 242/255, green: 89/255, blue: 64/255, alpha: 1.0)
    let selectedColor = UIColor.darkGrayColor()

    let grayColor = UIColor(red: 175/255, green: 175/255, blue: 175/255, alpha: 1.0)
    
    var blackView: UIView?

    
    override func viewDidLoad() {
        super.viewDidLoad()
		
		buttonsInitialPosition = addButton.center
		backgroundView.alpha = 0
		
		var storyboard = UIStoryboard(name: "Main", bundle: nil)
		
		myLogViewController = storyboard.instantiateViewControllerWithIdentifier("MyLogViewController") as! UIViewController
		browseViewController = storyboard.instantiateViewControllerWithIdentifier("BrowseViewController") as! UIViewController
		addViewController = storyboard.instantiateViewControllerWithIdentifier("AddViewController") as! UIViewController
		savedViewController = storyboard.instantiateViewControllerWithIdentifier("SavedViewController") as! UIViewController
		connectViewController = storyboard.instantiateViewControllerWithIdentifier("ConnectViewController") as! UIViewController
		
		viewControllers = [myLogViewController, browseViewController, savedViewController, connectViewController]
		buttons = [myLogButton, browseButton, savedButton, connectButton]
		labels = [myLogLabel, browseLabel, savedLabel, forumLabel]
        
//        for(var i = 0; i < 4; i++){
//            buttons[i].contentEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10)
//        }
		
		loadContentView(myLogViewController)
		myLogButton.selected = true
        myLogLabel.textColor = selectedColor
		
		NSNotificationCenter.defaultCenter().addObserver(self, selector: "didSaveLogBounceAnimationOnNotification", name: didSaveNewLog, object: nil)
        
	}


    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	
	func setupMenu() {
		startingPoint = 650
		fiveButton.center.y = startingPoint
		vButton.center.y = startingPoint
//		backgroundView.backgroundColor = UIColor(red:0.0, green:0.0, blue:0.0, alpha:0.2)
	}
	


	@IBAction func currentPressedButton(sender: UIButton){
		for(var i = 0; i < 4; i++){
			if (sender.tag == i){
				setButtons()
				selectedButton = buttons[i]
                selectedLabel = labels[i]
				selectedViewController = viewControllers[i]
				selectedButton.selected = true
                selectedLabel.textColor = selectedColor
//                playBounceAnimation(selectedButton)
				
				for view in contentView.subviews{
					view.removeFromSuperview()
				}
				loadContentView(selectedViewController)
			}
		}
	}
	
	func setButtons(){
		for i in 0 ..< 4 {
			buttons[i].selected = false
            labels[i].textColor = grayColor
		}
	}
	
	func loadContentView(ViewController: UIViewController){
		addChildViewController(ViewController)
		ViewController.view.frame = contentView.bounds
		contentView.addSubview(ViewController.view)
		ViewController.didMoveToParentViewController(self)
	}
	
    
    func playBounceAnimation(icon : UIButton) {

        let bounceAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        bounceAnimation.values = [1.0 ,1.4, 0.9, 1.15, 0.95, 1.02, 1.0]
        bounceAnimation.duration = 1.2
        bounceAnimation.calculationMode = kCAAnimationCubic
        
//      Commenting out the bounce on the icons for now.
        icon.layer.addAnimation(bounceAnimation, forKey: "bounceAnimation")
//		icon.image.backgroundColor = UIColor.redColor()
//		delay(1.3, { () -> () in
//			icon.backgroundColor = UIColor.grayColor()
//		})
    }
	
	@IBAction func didPressAddButton(sender: AnyObject) {
//		addViewController.transitioningDelegate = self
//		presentViewController(addViewController, animated: true, completion: nil)
        
        var angle: CGFloat?

		fiveButton.alpha = 1
		vButton.alpha = 1
        
        if flyoutOpen == false {
            handleAddButtonTap()
            transitionIn()

        }
        else if flyoutOpen == true {
            handleAddButtonTap()
            transitionOut()

        }
        

    
    }
    
    
 func handleAddButtonTap() {
        var angle: CGFloat?
        
        if flyoutOpen == false {
                angle = CGFloat(M_PI_4) + CGFloat(M_PI)
        }
        else if flyoutOpen == true {
                angle = 0.0
        }
    
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.addButton.transform = CGAffineTransformMakeRotation(angle!)
        })
        
    }
    
	
	func transitionIn(){
		UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.25, options: nil, animations: { () -> Void in
			self.fiveButton.center = self.fiveButtonFinalPosition
            self.vButton.center = self.vButtonFinalPosition
            self.addClimbLabel.center = self.addClimbLabelFinalPosition
			self.backgroundView.alpha = 0.5
			}, completion: nil)
        
        flyoutOpen = true

	}
	
	func transitionOut() {
		UIView.animateWithDuration(0.4, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: nil, animations: { () -> Void in
			self.fiveButton.center = self.buttonsInitialPosition
             self.vButton.center = self.buttonsInitialPosition
            self.addClimbLabel.center = self.addClimbLabelInitialPosition

            self.backgroundView.alpha = 0
			}, completion: nil)
        
        flyoutOpen = false

	}
	
    @IBAction func didTapFlyoutBackground(sender: AnyObject) {
        handleAddButtonTap()
        transitionOut()
    }
    
	func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		return transition
	}
	
	func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		return transition
	}
    
	@IBAction func didPressButton(sender: AnyObject) {
		
		handleAddButtonTap()
		
		transitionOut()
		
//		if (sender as! NSObject == fiveButton){
//			performSegueWithIdentifier("fiveButtonSegue", sender: self)
//		}
//		else if (sender as! NSObject == vButton){
//			performSegueWithIdentifier("vButtonSegue", sender: self)
//		}
	}
	
	override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
		var destinationViewController = segue.destinationViewController as! UINavigationController
		
		var topViewController = destinationViewController.topViewController as! AddDetailViewController
		print(sender as! NSObject)
		if (sender as! NSObject == fiveButton){
			topViewController.isFiveButton = true
		}
		else if (sender as! NSObject == vButton){
			topViewController.isFiveButton = false
		}
		
//		print(topViewController.isFiveButton)
	}
	
	func didSaveLogBounceAnimationOnNotification(){
		playBounceAnimation(myLogButton)

	}

}
