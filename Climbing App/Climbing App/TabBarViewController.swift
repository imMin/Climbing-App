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
	
	var myLogViewController: UIViewController!
	var browseViewController: UIViewController!
	var addViewController: UIViewController!
	var savedViewController: UIViewController!
	var connectViewController: UIViewController!
	var selectedButton: UIButton!
	var selectedViewController: UIViewController!
	var viewControllers: [UIViewController]!
	var buttons: [UIButton]!
	let transition = addTransition()
	
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
		
		
		loadContentView(myLogViewController)
		myLogButton.selected = true
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
				selectedViewController = viewControllers[i]
				selectedButton.selected = true
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
		}
	}
	
	func loadContentView(ViewController: UIViewController){
		addChildViewController(ViewController)
		ViewController.view.frame = contentView.bounds
		contentView.addSubview(ViewController.view)
		ViewController.didMoveToParentViewController(self)
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
