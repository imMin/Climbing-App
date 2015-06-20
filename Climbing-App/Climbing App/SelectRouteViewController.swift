//
//  SelectRouteViewController.swift
//  Climbing App
//
//  Created by Min Hu on 6/17/15.
//  Copyright (c) 2015 Min Hu. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class SelectRouteViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate, MKMapViewDelegate {
	
//	@IBOutlet weak var selectMapView: MKMapView!
	@IBOutlet weak var selectTableView: UITableView!
	
	var region: String!
	var manager:CLLocationManager!
	var myLocations:[CLLocation] = []
	var location: CLLocation!
	
	var routeNames = ["routeName1", "routeName2", "routeName3", "routeName4", "routeName5"]
	var routeLevels = ["5.9", "5.10a", "5.11a", "5.12b", "5.10c", "5.9", "5.10a", "5.11a", "5.12b", "5.10c"]
	
	var cragDistances = ["0.3mi", "0.5mi", "0.7mi", "1.5mi"]
	
	var climbNumbers = ["3 routes", "5 routes", "4 routes", "5 routes"]
	
	var crags = ["Cragname one", "Cragname two", "Cragname three"]
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		selectTableView.delegate = self
		selectTableView.dataSource = self
		
		//Set up Location Manager
//		manager = CLLocationManager()
//		manager.delegate = self
//		manager.desiredAccuracy = kCLLocationAccuracyBest
//		manager.requestAlwaysAuthorization()
//		manager.startUpdatingLocation()
		
		//Set up Map View
//		selectMapView.delegate = self
//		selectMapView.mapType = MKMapType.Hybrid
//		selectMapView.showsPointsOfInterest = false
//		selectMapView.showsUserLocation = true
//		
//		var region : MKCoordinateRegion
//		region = MKCoordinateRegionMake(CLLocationCoordinate2DMake(39.3761, -104.8535), MKCoordinateSpanMake(0.01, 0.01))
//		region = selectMapView.regionThatFits(region)
//		selectMapView.setRegion(region, animated: false)
//		
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return routeNames.count
	}
	
	func tableView(tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int {
		return crags.count
	}
	
	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return crags.count
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		var cell = selectTableView.dequeueReusableCellWithIdentifier("SelectRouteCell") as! SelectRouteCell
		
		cell.routeNameLabel.text = routeNames[indexPath.row]
		cell.levelLabel.text = routeLevels[indexPath.row]
		
		return cell
	}
	
	func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		var headerView = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 80))
		headerView.backgroundColor = UIColor(white: 0.2, alpha: 0.5)
		
		var cragNameLabel = UILabel(frame:CGRect(x: 10, y: 0, width: 300, height: 40))
		cragNameLabel.text = crags[section]
		
		var distanceLabel = UILabel(frame:CGRect(x: 300, y: 0, width: 60, height: 40))
		distanceLabel.text = cragDistances[section]

		headerView.addSubview(cragNameLabel)
		headerView.addSubview(distanceLabel)
		
		return headerView
	}
	
	func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 40
	}
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if (segue.identifier == "selectRouteSegue") {
			
			// initialize new view controller and cast it as your view controller
			var viewController = segue.destinationViewController as! AddDetailViewController
			
			let indexPath : NSIndexPath = self.selectTableView.indexPathForSelectedRow()!
			
			// your new view controller should have property that will store passed value
			viewController.routeName = routeNames[indexPath.row]
			viewController.level = routeLevels[indexPath.row]
		}
	}
	
//	func locationManager(manager:CLLocationManager, didUpdateLocations locations:[AnyObject]) {
//		//		location = "\(locations[0])"
//		myLocations.append(locations[0] as! CLLocation)
//		
//		let spanX = 0.01
//		let spanY = 0.01
//		var newRegion = MKCoordinateRegion(center: selectMapView.userLocation.coordinate, span: MKCoordinateSpanMake(spanX, spanY))
//		selectMapView.setRegion(newRegion, animated: true)
//		
//	}

	@IBAction func didPressCancelButton(sender: AnyObject) {
		dismissViewControllerAnimated(true, completion: nil)
	}
	
	@IBAction func didPressSaveButton(sender: AnyObject) {
		dismissViewControllerAnimated(true, completion: nil)
	}
	
	
}
