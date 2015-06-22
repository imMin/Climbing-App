//
//  AddDetailViewController.swift
//  Climbing App
//
//  Created by Min Hu on 6/15/15.
//  Copyright (c) 2015 Min Hu. All rights reserved.
//

import UIKit

let didSaveNewLog = "did you just save a new log?"


class AddDetailViewController: UIViewController, UIScrollViewDelegate, SelectRouteViewControllerDelegate {

	
	var routeName: String!
	var selectedLevel : Int!
	var level: String!
	var levelLabels:[UILabel]!
    var vLevelLabels:[UILabel]!
	var initialOffset: Float!
	var moved: Float!
	var movedLevel: Int!
	var scrollVelocity: CGPoint!
	var pageNumber: Int!
	var previousPageNumber: Int!
	var rect : CGRect!
	var context: CGContextRef!
	var typeButtons: [UIButton]!
	var styleButtons: [UIButton]!
	var isFiveButton = true
	var selectRouteViewController: UIViewController!
	
	@IBOutlet weak var addLocationButton: UIButton!
//	var typeSegBackgroundImage: UIImage!
	@IBOutlet weak var leadButton: UIButton!
	@IBOutlet weak var topRopeButton: UIButton!
	@IBOutlet weak var tradButton: UIButton!
	@IBOutlet weak var onSightButton: UIButton!
	@IBOutlet weak var flashButton: UIButton!
	@IBOutlet weak var redPointButton: UIButton!
	
	
	@IBOutlet weak var routeNameLabel: UILabel!
	@IBOutlet weak var levelLabel: UILabel!
	@IBOutlet weak var levelScrollView: UIScrollView!
    @IBOutlet weak var vLeveLScrollView: UIScrollView!
	@IBOutlet weak var touchableView: UIView!
	@IBOutlet weak var typeSegmentedControl: UISegmentedControl!
	@IBOutlet weak var vScaleTouchableView: UIView!
	
	
	@IBOutlet weak var five6Label: UILabel!
	@IBOutlet weak var five7Label: UILabel!
	@IBOutlet weak var five8Label: UILabel!
	@IBOutlet weak var five9Label: UILabel!
	@IBOutlet weak var five10aLabel: UILabel!
	@IBOutlet weak var five10bLabel: UILabel!
	@IBOutlet weak var five10cLabel: UILabel!
	@IBOutlet weak var five10dLabel: UILabel!
	@IBOutlet weak var five11aLabel: UILabel!
	@IBOutlet weak var five11bLabel: UILabel!
	@IBOutlet weak var five11cLabel: UILabel!
	@IBOutlet weak var five11dLabel: UILabel!
	@IBOutlet weak var five12aLabel: UILabel!
	@IBOutlet weak var five12bLabel: UILabel!
	@IBOutlet weak var five12cLabel: UILabel!
	@IBOutlet weak var five12dLabel: UILabel!
	@IBOutlet weak var five13aLabel: UILabel!
	@IBOutlet weak var five13bLabel: UILabel!
	@IBOutlet weak var five13cLabel: UILabel!
	@IBOutlet weak var five13dLabel: UILabel!
	@IBOutlet weak var five14aLabel: UILabel!
	@IBOutlet weak var five14bLabel: UILabel!
	@IBOutlet weak var five14cLabel: UILabel!
	@IBOutlet weak var five14dLabel: UILabel!
	
    @IBOutlet weak var VBLabel: UILabel!
    @IBOutlet weak var V0Label: UILabel!
    @IBOutlet weak var V0plusLabel: UILabel!
    @IBOutlet weak var V1Label: UILabel!
    @IBOutlet weak var V2Label: UILabel!
    @IBOutlet weak var V3Label: UILabel!
    @IBOutlet weak var V4Label: UILabel!
    @IBOutlet weak var V5Label: UILabel!
    @IBOutlet weak var V6Label: UILabel!
    @IBOutlet weak var V7Label: UILabel!
    @IBOutlet weak var V8Label: UILabel!
    @IBOutlet weak var V9Label: UILabel!
    @IBOutlet weak var V10Label: UILabel!
    @IBOutlet weak var V11Label: UILabel!
    @IBOutlet weak var V12Label: UILabel!
    @IBOutlet weak var V13Label: UILabel!
    @IBOutlet weak var V14Label: UILabel!
    @IBOutlet weak var V15Label: UILabel!
    @IBOutlet weak var V16Label: UILabel!
    
	@IBOutlet weak var locationContentView: UIView!
    
    
	var levels = ["5.6", "5.7", "5.8", "5.9", "5.10a", "5.10b", "5.10c", "5.10d", "5.11a", "5.11b", "5.11c", "5.11d", "5.12a", "5.12b", "5.12c", "5.12d", "5.13a", "5.13b", "5.13c", "5.13d", "5.14a", "5.14b", "5.14c", "5.14d"]
    
    var vLevels = ["VB", "V0", "V0+", "V1", "V2", "V3", "V4", "V5", "V6", "V7", "V8", "V9", "V10", "V11", "V12", "V13", "V14", "V15", "V16"]
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		//decide which labels to show
		if (isFiveButton == true){
			vScaleTouchableView.hidden = true
		}
		else if (isFiveButton == false){
			touchableView.hidden = true
		}
		
		routeNameLabel.text = routeName
		//set scrollview content size
//		levelLabel.text = level
		levelScrollView.contentSize = CGSizeMake(CGFloat(levels.count) * 100, 80.0)
		levelScrollView.clipsToBounds = false
    
        vLeveLScrollView.contentSize = CGSizeMake(CGFloat(vLevels.count) * 100, 80.0)
		vLeveLScrollView.clipsToBounds = false

		
//		selectedLevel = find(levels, level)
        selectedLevel = 4
		pageNumber = 4
		self.changePage(4, animated: false)
        self.ChangeVPage(4, animated: false)
		
		
		levelLabels = [five6Label, five7Label, five8Label, five9Label, five10aLabel, five10bLabel, five10cLabel, five10dLabel, five11aLabel, five11bLabel, five11cLabel, five11dLabel, five12aLabel, five12bLabel, five12cLabel, five12dLabel, five13aLabel, five13bLabel, five13cLabel, five13dLabel, five14aLabel, five14bLabel, five14cLabel, five14dLabel]
        
        vLevelLabels = [VBLabel, V0Label, V0plusLabel, V1Label, V2Label, V3Label, V4Label, V5Label, V6Label, V7Label, V8Label, V9Label, V10Label, V11Label, V12Label, V13Label, V14Label, V15Label, V16Label]

		levelScrollView.delegate = self
		vLeveLScrollView.delegate = self
        
		touchableView.addGestureRecognizer(levelScrollView.panGestureRecognizer)
		vScaleTouchableView.addGestureRecognizer(vLeveLScrollView.panGestureRecognizer)
		
		typeButtons = [leadButton, topRopeButton, tradButton]
		
		styleButtons = [onSightButton, flashButton, redPointButton]
		
		typeButtons[1].selected = true
		styleButtons[1].selected = true

		//load route list into content container view
		var storyboard = UIStoryboard(name: "Main", bundle: nil)
		selectRouteViewController = storyboard.instantiateViewControllerWithIdentifier("SelectRouteViewController") as! UIViewController
		
		locationContentView.frame.origin.y = 490
		locationContentView.hidden = true
		
    }
	
	override func viewWillAppear(animated: Bool) {
		setScale()
        setVScale()
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	@IBAction func didPressCancelButton(sender: AnyObject) {
		dismissViewControllerAnimated(true, completion: nil)
	}
	
	
	@IBAction func didPressSaveButton(sender: AnyObject) {
		dismissViewControllerAnimated(true, completion: nil)
		
		NSNotificationCenter.defaultCenter().postNotificationName(didSaveNewLog, object: self)
	}

	
	func setScale(){
		previousPageNumber = pageNumber
		for (var i = 0; i < levels.count; i++ ){
			if (i != selectedLevel){
				levelLabels[i].alpha = 0.44
			}
		}
		
		levelLabels[selectedLevel].transform = CGAffineTransformScale(levelLabels[selectedLevel].transform, 1.2, 1.2)
	}
    
    func setVScale(){
        previousPageNumber = pageNumber
        for (var i = 0; i < vLevels.count; i++ ){
            if (i != selectedLevel){
                vLevelLabels[i].alpha = 0.44
            }
        }

        vLevelLabels[selectedLevel].transform = CGAffineTransformScale(vLevelLabels[selectedLevel].transform, 1.2, 1.2)
    }
    
	
	func scrollViewDidScroll(scrollView: UIScrollView) {

        let currentPageNumber = Int(round(scrollView.contentOffset.x / 100))

//		if (previousPageNumber != currentPageNumber && currentPageNumber < levelLabels.count && currentPageNumber >= 0) {
//			let label = levelLabels[currentPageNumber]
//            let vLabel = vLevelLabels[currentPageNumber]
//            
//			label.transform = CGAffineTransformScale(label.transform, 1.2, 1.2)
//            vLabel.transform = CGAffineTransformScale(vLabel.transform, 1.2, 1.2)
//            
//			levelLabels[currentPageNumber].alpha = 1
//			vLevelLabels[currentPageNumber].alpha = 1
//            
//			levelLabels[previousPageNumber].transform = CGAffineTransformIdentity
//			levelLabels[previousPageNumber].alpha = 0.44
//			vLevelLabels[previousPageNumber].transform = CGAffineTransformIdentity
//            vLevelLabels[previousPageNumber].alpha = 0.44
//            
//			previousPageNumber = currentPageNumber
//		}
		
		if (isFiveButton == true){
			if (previousPageNumber != currentPageNumber && currentPageNumber < levelLabels.count && currentPageNumber >= 0) {
				let label = levelLabels[currentPageNumber]
				
				label.transform = CGAffineTransformScale(label.transform, 1.2, 1.2)
				
				levelLabels[currentPageNumber].alpha = 1
				levelLabels[previousPageNumber].transform = CGAffineTransformIdentity
				levelLabels[previousPageNumber].alpha = 0.44
				previousPageNumber = currentPageNumber
			}
		}
		
		else if (isFiveButton == false){
			if (previousPageNumber != currentPageNumber && currentPageNumber < vLevelLabels.count && currentPageNumber >= 0) {
				let vLabel = vLevelLabels[currentPageNumber]
				
				vLabel.transform = CGAffineTransformScale(vLabel.transform, 1.2, 1.2)
				vLevelLabels[currentPageNumber].alpha = 1

				vLevelLabels[previousPageNumber].transform = CGAffineTransformIdentity
				vLevelLabels[previousPageNumber].alpha = 0.44
				
				previousPageNumber = currentPageNumber
			}
		}
		
		
	}
	
	func scrollViewWillBeginDragging(scrollView: UIScrollView) {
		initialOffset = Float(scrollView.contentOffset.x)
	}
	
	func scrollViewDidEndDragging(scrollView: UIScrollView,
		willDecelerate decelerate: Bool) {
			
	}
	
	func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
		pageNumber = Int(scrollView.contentOffset.x / 100)
	}
	
	func changePage(page: Int, animated: Bool) {
		let x = CGFloat(page) * levelScrollView.frame.size.width
		levelScrollView.setContentOffset(CGPointMake(x, 0), animated: animated)
	}
    
    func ChangeVPage(page: Int, animated: Bool){
        let x = CGFloat(page) * vLeveLScrollView.frame.size.width
        vLeveLScrollView.setContentOffset(CGPointMake(x, 0), animated: animated)
    }
	
	
	func convertValue(value: Float, r1Min: Float, r1Max: Float, r2Min: Float, r2Max: Float) -> Float{
		var ratio = (r2Max - r2Min)/(r1Max - r1Min) //(0.8333-1)/(220-320)
		return value * ratio + r2Min - r1Min * ratio
	}
	
	@IBAction func didSelectType(sender: AnyObject) {
		for (var i = 0; i < typeButtons.count; i++){
			if sender.tag != i{
				typeButtons[i].selected = false
			}
			else{
				typeButtons[i].selected = true
			}
		}
		
	}
	
	@IBAction func didSelectStyle(sender: AnyObject) {
		for (var i = 0; i < styleButtons.count; i++){
			if sender.tag != i{
				styleButtons[i].selected = false
			}
			else {
				styleButtons[i].selected = true
			}
		}
	
	}
	
	@IBAction func didPressAddLocation(sender: AnyObject) {
		
//		AddDetailViewController.transitionStyle = UIModalTransitionStyle.CoverVertical
//		self.presentViewController(SelectRouteViewController, animated: true, completion: nil)
		//load select route VC into routeContentView
		self.locationContentView.hidden = false
		var selectRouteCastViewController = selectRouteViewController as! SelectRouteViewController
		selectRouteCastViewController.delegate = self
		loadContentView(selectRouteViewController)
//		print("loaded!")
		UIView.animateWithDuration(0.5, delay: 0, options:.CurveEaseIn, animations: { () -> Void in
			self.locationContentView.frame.origin.y = 0
		}, completion: nil)
		
	}
	
	func loadContentView(ViewController: UIViewController){
		addChildViewController(ViewController)
		ViewController.view.frame = locationContentView.bounds
		locationContentView.addSubview(ViewController.view)
		ViewController.didMoveToParentViewController(self)
	}
	
	func selectRoute(controller: SelectRouteViewController, text: String) {
		addLocationButton.setTitle(text, forState: UIControlState.Normal)
//		self.selectRouteViewController.removeFromParentViewController()
		locationContentView.hidden = true
	}
	
}
