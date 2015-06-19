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

class BrowseCragViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate, MKMapViewDelegate {
	
	@IBOutlet weak var cragMapView: MKMapView!
	@IBOutlet weak var cragTableView: UITableView!
	
	var region: String!
	var manager:CLLocationManager!
	var myLocations:[CLLocation] = []
	var location: CLLocation!
	
	var cragNames = ["Lyme Disease Rock", "Indian Rock", "Waterfall Cliffs", "Billy Goat Rock", "cragName5", "cragName6", "cragName7", "cragName8", "cragName9", "cragName10"]
	
	var cragDistances = ["0.3mi", "0.5mi", "0.7mi", "1.5mi", "1.8mi", "2.1mi", "14mi", "15mi", "18mi", "22mi"]
	
	var climbNumbers = ["3 routes", "5 routes", "4 routes", "5 routes", "7 routes", "2 routes", "3 routes", "4 routes", "3 routes", "2 routes"]
	
	var regions = ["Castle Rock"]
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		cragTableView.delegate = self
		cragTableView.dataSource = self
		
		//Set up Location Manager
		manager = CLLocationManager()
		manager.delegate = self
		manager.desiredAccuracy = kCLLocationAccuracyBest
		manager.requestAlwaysAuthorization()
		manager.startUpdatingLocation()
		
		//Set up Map View
		cragMapView.delegate = self
		cragMapView.mapType = MKMapType.Hybrid
		cragMapView.showsPointsOfInterest = false
		cragMapView.showsUserLocation = true
		
		var region : MKCoordinateRegion
		region = MKCoordinateRegionMake(CLLocationCoordinate2DMake(39.3761, -104.8535), MKCoordinateSpanMake(0.01, 0.01))
		region = cragMapView.regionThatFits(region)
		cragMapView.setRegion(region, animated: false)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

//	func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
//		let location = locations.last as! CLLocation
//		
//		let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
//		let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
//		
//		self.cragMapView.setRegion(region, animated: true)
//	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 4
	}

	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		var cell = cragTableView.dequeueReusableCellWithIdentifier("BrowseCragCell") as! BrowseCragCell
		
		cell.cragNameLabel.text = cragNames[indexPath.row]
		cell.cragDistanceLabel.text = cragDistances[indexPath.row]
		cell.climbNumberLabel.text = climbNumbers[indexPath.row]
		
		return cell
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
	
	
	func locationManager(manager:CLLocationManager, didUpdateLocations locations:[AnyObject]) {
		//		location = "\(locations[0])"
		myLocations.append(locations[0] as! CLLocation)
		
		let spanX = 0.01
		let spanY = 0.01
		var newRegion = MKCoordinateRegion(center: cragMapView.userLocation.coordinate, span: MKCoordinateSpanMake(spanX, spanY))
		cragMapView.setRegion(newRegion, animated: true)

	}

}
