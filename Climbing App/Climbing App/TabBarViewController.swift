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
	
    @IBOutlet weak var myLogLabel: UILabel!
    @IBOutlet weak var browseLabel: UILabel!
    @IBOutlet weak var forumLabel: UILabel!
    @IBOutlet weak var savedLabel: UILabel!
    
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
	let transition = addTransition()
    var labels: [UILabel]!
    
    let redColor = UIColor(red: 242/255, green: 89/255, blue: 64/255, alpha: 1.0)
    let selectedColor = UIColor.darkGrayColor()

    let grayColor = UIColor(red: 191/255, green: 191/255, blue: 191/255, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
		
		var storyboard = UIStoryboard(name: "Main", bundle: nil)
		
		myLogViewController = storyboard.instantiateViewControllerWithIdentifier("MyLogViewController") as! UIViewController
		browseViewController = storyboard.instantiateViewControllerWithIdentifier("BrowseViewController") as! UIViewController
		addViewController = storyboard.instantiateViewControllerWithIdentifier("AddViewController") as! UIViewController
		savedViewController = storyboard.instantiateViewControllerWithIdentifier("SavedViewController") as! UIViewController
		connectViewController = storyboard.instantiateViewControllerWithIdentifier("ConnectViewController") as! UIViewController
		
		viewControllers = [myLogViewController, browseViewController, savedViewController, connectViewController]
		buttons = [myLogButton, browseButton, savedButton, connectButton]
		labels = [myLogLabel, browseLabel, savedLabel, forumLabel]
		
		loadContentView(myLogViewController)
		myLogButton.selected = true
        myLogLabel.textColor = selectedColor
	}


    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
                playBounceAnimation(selectedButton)
                
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
        bounceAnimation.duration = 0.7
        bounceAnimation.calculationMode = kCAAnimationCubic
        
        icon.layer.addAnimation(bounceAnimation, forKey: "bounceAnimation")
        
    }
	
	@IBAction func didPressAddButton(sender: AnyObject) {
		addViewController.transitioningDelegate = self
		presentViewController(addViewController, animated: true, completion: nil)
		
	}
	
	func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		return transition
	}
	
	func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		return transition
	}
}
