//
//  BrowseCragViewController.swift
//  Climbing App
//
//  Created by Min Hu on 6/12/15.
//  Copyright (c) 2015 Min Hu. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class BrowseCragViewController: UIViewController, CLLocationManagerDelegate, UITableViewDataSource, UITableViewDelegate {
	
	@IBOutlet weak var locationMapView: MKMapView!
	@IBOutlet weak var cragTableView: UITableView!
	
	var region: String!
	var locationManager: CLLocationManager!
	
	var cragNames = ["cragName1", "cragName2", "cragName3", "cragName4", "cragName5", "cragName6", "cragName7", "cragName8", "cragName9", "cragName10"]
	
	var cragDistances = ["0.3mi", "0.5mi", "0.7mi", "1.5mi", "1.8mi", "2.1mi", "14mi", "15mi", "18mi", "22mi"]
	
	var climbNumbers = ["3 routes", "5 routes", "4 routes", "5 routes", "7 routes", "2 routes", "3 routes", "4 routes", "3 routes", "2 routes"]
	
	var regions = ["Castle Rock", "Mt Diablo", "Yosemite"]
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		cragTableView.delegate = self
		cragTableView.dataSource = self
		
		//locationMapView.showsUserLocation = true
		
		//if (CLLocationManager.locationServicesEnabled())
		//{
		//	locationManager = CLLocationManager()
		//	locationManager.delegate = self
		//	locationManager.desiredAccuracy = kCLLocationAccuracyBest
		//	locationManager.requestAlwaysAuthorization()
		//	locationManager.startUpdatingLocation()
		//}
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

	func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
		let location = locations.last as! CLLocation
		
		let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
		let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
		
		self.locationMapView.setRegion(region, animated: true)
	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 4
	}
	
	func tableView(tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int {
		return 7
	}

	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return regions.count
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		var cell = cragTableView.dequeueReusableCellWithIdentifier("BrowseCragCell") as! BrowseCragCell
		
		cell.cragNameLabel.text = cragNames[indexPath.row]
		cell.cragDistanceLabel.text = cragDistances[indexPath.row]
		cell.climbNumberLabel.text = climbNumbers[indexPath.row]
		
		return cell
	}
	
	func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		var headerView = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 80))
		headerView.backgroundColor = UIColor(white: 0.2, alpha: 0.5)
		
		var label = UILabel(frame:CGRect(x: 10, y: 0, width: 300, height: 40))
		label.text = regions[section]
		headerView.addSubview(label)
		
		return headerView
	}
	
	func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 40
	}
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if (segue.identifier == "cragDetailSegue") {
			
			// initialize new view controller and cast it as your view controller
			var viewController = segue.destinationViewController as! CragDetailViewController
			
			let indexPath : NSIndexPath = self.cragTableView.indexPathForSelectedRow()!
			
			// your new view controller should have property that will store passed value
			viewController.cragName = cragNames[indexPath.row]
			viewController.cragDistance = cragDistances[indexPath.row]
			viewController.climbNumber = climbNumbers[indexPath.row]
		}
	}
	
	@IBAction func didPressBackButton(sender: AnyObject) {
		navigationController?.popViewControllerAnimated(true)
	}
}
