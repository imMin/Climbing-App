//
//  TabBarViewController.swift
//  Climbing App
//
//  Created by Min Hu on 6/12/15.
//  Copyright (c) 2015 Min Hu. All rights reserved.


import UIKit

class TabBarViewController: UIViewController, UIViewControllerTransitioningDelegate, PathMenuDelegate {

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

    let grayColor = UIColor(red: 175/255, green: 175/255, blue: 175/255, alpha: 1.0)
    
    var blackView: UIView?

    
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
        
//        for(var i = 0; i < 4; i++){
//            buttons[i].contentEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10)
//        }
		
		loadContentView(myLogViewController)
		myLogButton.selected = true
        myLogLabel.textColor = selectedColor
        
//        setupPathMenu()
	}


    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    func setupPathMenu() {
//        let storyMenuItemImage: UIImage = UIImage(named: "bg-menuitem")!
//        let storyMenuItemImagePressed: UIImage = UIImage(named: "bg-menuitem-highlighted")!
//        
//        let starImage: UIImage = UIImage(named: "icon-star")!
//        
//        let starMenuItem1: PathMenuItem = PathMenuItem(image: storyMenuItemImage, highlightedImage: storyMenuItemImagePressed, ContentImage: starImage, highlightedContentImage:nil)
//        
//        let starMenuItem2: PathMenuItem = PathMenuItem(image: storyMenuItemImage, highlightedImage: storyMenuItemImagePressed, ContentImage: starImage, highlightedContentImage:nil)
//        
//        var menus: [PathMenuItem] = [starMenuItem1, starMenuItem2]
//        
//        let startItem: PathMenuItem = PathMenuItem(image: UIImage(named: "bg-addbutton"), highlightedImage: UIImage(named: "bg-addbutton-highlighted"), ContentImage: UIImage(named: "icon-plus"), highlightedContentImage: UIImage(named: "icon-plus-highlighted"))
//        
//        var menu: PathMenu = PathMenu(frame: self.view.bounds, startItem: startItem, optionMenus: menus)
//        menu.delegate = self
//        menu.startPoint = CGPointMake(UIScreen.mainScreen().bounds.width/2, self.view.frame.size.height - 30.0)
//        menu.menuWholeAngle = CGFloat(M_PI/3)
//        menu.rotateAngle = -CGFloat(M_PI/6)
////        menu.rotateAngle = -CGFloat(M_PI_2) + CGFloat(M_PI/5) * 1/2
//        menu.timeOffset = 0.0
//        menu.farRadius = 90.0
//        menu.nearRadius = 70.0
//        menu.endRadius = 80.0
//        menu.animationDuration = 0.5
//        
//        self.blackView = UIView(frame: UIScreen.mainScreen().bounds)
//        self.blackView?.addSubview(menu)
//        self.blackView?.backgroundColor = UIColor.clearColor()
//        self.view.addSubview(self.blackView!)
//        self.view.backgroundColor = UIColor(red:0.96, green:0.94, blue:0.92, alpha:1)
//
//    }
	
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
    
//    //MARK: PathMenuDelegate
//    
//    func pathMenu(menu: PathMenu, didSelectIndex idx: Int) {
//        println("Select the index : \(idx)")
//        self.blackView?.backgroundColor = UIColor.clearColor()
//    }
//    
//    func pathMenuWillAnimateOpen(menu: PathMenu) {
//        println("Menu will open!")
//        self.blackView?.backgroundColor = UIColor(red:0.0, green:0.0, blue:0.0, alpha:0.7)
//
//    }
//    
//    func pathMenuWillAnimateClose(menu: PathMenu) {
//        println("Menu will close!")
//    }
//    
//    func pathMenuDidFinishAnimationOpen(menu: PathMenu) {
//        println("Menu was open!")
//    }
//    
//    func pathMenuDidFinishAnimationClose(menu: PathMenu) {
//        println("Menu was closed!")
//        self.blackView?.backgroundColor = UIColor.clearColor()
//    }

}
