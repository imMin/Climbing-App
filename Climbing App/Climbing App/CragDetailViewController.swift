//
//  CragDetailViewController.swift
//  Climbing App
//
//  Created by Min Hu on 6/14/15.
//  Copyright (c) 2015 Min Hu. All rights reserved.
//

import UIKit

class CragDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
	
	var cragName: String!
	var climbNumber: String!
	var cragDistance: String!
	
	@IBOutlet weak var cragNameLabel: UILabel!
	@IBOutlet weak var climbNumberLabel: UILabel!
	@IBOutlet weak var cragDistanceLabel: UILabel!
	@IBOutlet weak var climbTableView: UITableView!
	
	var climbNames = ["Triple Overhang", "The Great Roof", "Swiss Cheese", "The Great Roof", "Tripple Overhang"]
	var climbLevels = ["5.9", "5.10a", "5.12b", "5.11a", "5.10c"]
	var climbTypes = ["sports", "top rope", "sports", "top rope", "sports"]
	var climbNumbers = ["172", "15", "23", "42", "42"]
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		climbTableView.delegate = self
		climbTableView.dataSource = self
		
		self.cragNameLabel.text = cragName
		self.climbNumberLabel.text = climbNumber
		self.cragDistanceLabel.text = cragDistance

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

	@IBAction func didPressBackButton(sender: AnyObject) {
		navigationController?.popViewControllerAnimated(true)
	}
	
	//table view funcations
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return climbNames.count
	}
	
	func tableView(tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int {
		return 1
	}
	
	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		var cell = climbTableView.dequeueReusableCellWithIdentifier("ClimbCell") as! ClimbCell
		
		cell.climbNameLabel.text = climbNames[indexPath.row]
		cell.climbNumberLabel.text = climbNumbers[indexPath.row]
		cell.climbTypeLabel.text = climbTypes[indexPath.row]
		cell.climbNumberLabel.text = climbNumbers[indexPath.row]
		
		return cell
	}
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if (segue.identifier == "routeDetailSegue") {
			
			// initialize new view controller and cast it as your view controller
			var viewController = segue.destinationViewController as! RouteDetailViewController
			
			let indexPath : NSIndexPath = self.climbTableView.indexPathForSelectedRow()!
			
			// your new view controller should have property that will store passed value
			viewController.routeName = climbNames[indexPath.row]
			viewController.distance = cragDistance
			viewController.climb = climbNumbers[indexPath.row]
			viewController.level = climbLevels[indexPath.row]
		}
	}

}
