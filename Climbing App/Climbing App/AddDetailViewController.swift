//
//  AddDetailViewController.swift
//  Climbing App
//
//  Created by Min Hu on 6/15/15.
//  Copyright (c) 2015 Min Hu. All rights reserved.
//

import UIKit

class AddDetailViewController: UIViewController, UIScrollViewDelegate {

	
	var routeName: String!
	var selectedLevel : Int!
	var level: String!
	var levelLabels:[UILabel]!
	var initialOffset: Float!
	var moved: Float!
	var movedLevel: Int!
	var scrollVelocity: CGPoint!
	var pageNumber: Int!
	var previousPageNumber: Int!
	
	
	@IBOutlet weak var routeNameLabel: UILabel!
	@IBOutlet weak var levelLabel: UILabel!
	@IBOutlet weak var levelScrollView: UIScrollView!
	@IBOutlet weak var touchableView: UIView!
	
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
	
	
	var levels = ["5.6", "5.7", "5.8", "5.9", "5.10a", "5.10b", "5.10c", "5.10d", "5.11a", "5.11b", "5.11c", "5.11d", "5.12a", "5.12b", "5.12c", "5.12d", "5.13a", "5.13b", "5.13c", "5.13d", "5.14a", "5.14b", "5.14c", "5.14d"]
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		routeNameLabel.text = routeName
		
		levelLabel.text = level
		levelScrollView.contentSize = CGSizeMake(CGFloat(levels.count) * 100, 80.0)
		levelScrollView.clipsToBounds = false
		
		selectedLevel = find(levels, level)
		pageNumber = selectedLevel
		self.changePage(selectedLevel, animated: false)
		
		
		levelLabels = [five6Label, five7Label, five8Label, five9Label, five10aLabel, five10bLabel, five10cLabel, five10dLabel, five11aLabel, five11bLabel, five11cLabel, five11dLabel, five12aLabel, five12bLabel, five12cLabel, five12dLabel, five13aLabel, five13bLabel, five13cLabel, five13dLabel, five14aLabel, five14bLabel, five14cLabel, five14dLabel]

		levelScrollView.delegate = self
		
		touchableView.addGestureRecognizer(levelScrollView.panGestureRecognizer)
		
//		levelScrollView.panGestureRecognizer.actionForLayer(levelScrollView, forKey: "onCustomPan")
//		levelScrollView.panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "onCustomPan")
//		var panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "onCustomPan:")
//		levelScrollView.addGestureRecognizer(panGestureRecognizer)
    }
	
	override func viewWillAppear(animated: Bool) {
		setScale()
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	@IBAction func didPressCancelButton(sender: AnyObject) {
		dismissViewControllerAnimated(true, completion: nil)
	}
	
	
	func setScale(){
		previousPageNumber = pageNumber
		levelLabels[selectedLevel].transform = CGAffineTransformScale(levelLabels[selectedLevel].transform, 1.2, 1.2)
	}
	
	func scrollViewDidScroll(scrollView: UIScrollView) {

		let currentPageNumber = Int(round(scrollView.contentOffset.x / 100))

		if (previousPageNumber != currentPageNumber && currentPageNumber < levelLabels.count && currentPageNumber >= 0) {
			let label = levelLabels[currentPageNumber]
			label.transform = CGAffineTransformScale(label.transform, 1.2, 1.2)
			
			levelLabels[previousPageNumber].transform = CGAffineTransformIdentity
			
			previousPageNumber = currentPageNumber
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
	
	
	func convertValue(value: Float, r1Min: Float, r1Max: Float, r2Min: Float, r2Max: Float) -> Float{
		var ratio = (r2Max - r2Min)/(r1Max - r1Min) //(0.8333-1)/(220-320)
		return value * ratio + r2Min - r1Min * ratio
	}
	
}
