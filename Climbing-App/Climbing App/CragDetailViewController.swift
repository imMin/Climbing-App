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
	@IBOutlet weak var climbTableView: UITableView!
	
	var climbNames = ["Vicious Circles", "Blowing Bubbles", "Epic Confrontation", "Ouch Pouch", "C** Slot"]
	var climbLevels = ["5.9", "5.10a", "5.12b", "5.11a", "5.10c"]
	var climbTypes = ["Sport", "Top rope", "Sport", "Top rope", "Sports"]
	
    var routes: [PFObject] = [PFObject]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
		
		climbTableView.delegate = self
		climbTableView.dataSource = self
		
		self.cragNameLabel.text = cragName

        // Do any additional setup after loading the view.
        
        fetchRoutes()
    }


    func fetchRoutes() {
        var query = PFQuery(className: "Route")
        query.orderByAscending("createdAt")

        query.findObjectsInBackgroundWithBlock { (objects:[AnyObject]?, error:NSError?) -> Void in
            self.routes = objects as! [PFObject]
            self.climbTableView.reloadData()

            if error == nil {
                // The find succeeded.
                println("Successfully retrieved \(objects!.count) crags.")
                // Do something with the found objects
                if let objects = objects as? [PFObject] {
                    for object in objects {
                        println(object.objectId)
                    }
                }
            } else {
                // Log details of the failure
                println("Error: \(error!) \(error!.userInfo!)")
            }

        }

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
		return routes.count
	}
	
//	func tableView(tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int {
//		return 1
//	}
//	
//	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//		return 1
//	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		var cell = climbTableView.dequeueReusableCellWithIdentifier("ClimbCell") as! ClimbCell
		
        var route = routes[indexPath.row]
        cell.climbNameLabel.text = route["name"] as? String
        cell.climbLevelLabel.text = route["grade"] as? String
                
        var isTopRope = route["isTopRope"] as? Bool
        var isSport = route["isSport"] as? Bool
        var isTrad = route["isTrad"] as? Bool
        
        var climbTypes: String!
        if isTopRope == true && isSport == true {climbTypes = "Top rope, Sport"}
        else if isTopRope == true && isTrad == true {climbTypes = "Top rope, Trad"}
        else if isSport == true && isTrad == true {climbTypes = "Sport, Trad"}
        
        cell.climbTypeLabel.text = climbTypes
		
		return cell
	}
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if (segue.identifier == "routeDetailSegue") {
			
			// initialize new view controller and cast it as your view controller
			var viewController = segue.destinationViewController as! RouteDetailViewController
			
			let indexPath : NSIndexPath = self.climbTableView.indexPathForSelectedRow()!
			
			// your new view controller should have property that will store passed value
			viewController.routeName = routes[indexPath.row]["name"] as! String
			viewController.distance = cragDistance
			viewController.level = routes[indexPath.row]["grade"] as! String
		}
	}

}
