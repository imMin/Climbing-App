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

protocol SelectRouteViewControllerDelegate{
	func selectRoute(controller: SelectRouteViewController, text: String)
}

class SelectRouteViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate, MKMapViewDelegate {
	
	@IBOutlet weak var selectMapView: MKMapView!
	@IBOutlet weak var selectTableView: UITableView!
	
	@IBOutlet weak var contentView: UIView!
	
	var delegate: SelectRouteViewControllerDelegate? = nil
	var region: String!
	var manager:CLLocationManager!
	var myLocations:[CLLocation] = []
	var location: CLLocation!
	var cragName: String!
	
	var cragNames = ["Lyme Disease Rock", "Indian Rock", "Waterfall Cliffs", "Billy Goat Rock", "cragName5", "cragName6", "cragName7", "cragName8", "cragName9", "cragName10"]
	
	var cragDistances = ["0.3mi", "0.5mi", "0.7mi", "1.5mi", "1.8mi", "2.1mi", "14mi", "15mi", "18mi", "22mi", "0.3mi", "0.5mi", "0.7mi", "1.5mi", "1.8mi", "2.1mi", "14mi", "15mi", "18mi", "22mi", "0.3mi", "0.5mi", "0.7mi"]
	
	var climbNumbers = ["3 routes", "5 routes", "4 routes", "5 routes", "7 routes", "2 routes", "3 routes", "4 routes", "3 routes", "2 routes", "3 routes", "5 routes", "4 routes", "5 routes", "7 routes", "2 routes", "3 routes", "4 routes", "3 routes", "2 routes", "3 routes", "5 routes", "4 routes"]
	
	var regions = ["Castle Rock"]
	
	var crags: [PFObject] = [PFObject]()
	var currentLocation: CLLocation!
	var locManager: CLLocationManager!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		selectTableView.delegate = self
		selectTableView.dataSource = self
		
		//Set up Location Manager
		manager = CLLocationManager()
		manager.delegate = self
		manager.desiredAccuracy = kCLLocationAccuracyBest
		manager.requestAlwaysAuthorization()
		manager.startUpdatingLocation()
		
		//Set up Map View
		selectMapView.delegate = self
		selectMapView.mapType = MKMapType.Hybrid
		selectMapView.showsPointsOfInterest = false
		selectMapView.showsUserLocation = true
		
		var region : MKCoordinateRegion
		region = MKCoordinateRegionMake(CLLocationCoordinate2DMake(39.3761, -104.8535), MKCoordinateSpanMake(0.01, 0.01))
		region = selectMapView.regionThatFits(region)
		selectMapView.setRegion(region, animated: false)
		
		fetchCrags()
		//        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "fetchCrags", userInfo: nil, repeats: true)
		
		//create an instance of CLLocationManager and Request Authorization
		locManager = CLLocationManager()
		locManager.requestWhenInUseAuthorization()
		
		//check if user allows authorization
		if( CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedWhenInUse ||
			CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedAlways){
				currentLocation = locManager.location
		}
		
		addCurrentLocationPin()
		
	}
	
	
	func fetchCrags() {
		println("fetched crags")
		
		var query = PFQuery(className: "Crag")
		query.orderByAscending("createdAt")
		query.findObjectsInBackgroundWithBlock { (objects:[AnyObject]?, error:NSError?) -> Void in
			self.crags = objects as! [PFObject]
			self.selectTableView.reloadData()
			
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
	
//	override func viewWillAppear(animated: Bool) {
//		self.contentView.frame.origin.y = 0
//	}
//
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.crags.count
	}
	
	func tableView(tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int {
		return regions.count
	}
	
	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return regions.count
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		var cell = selectTableView.dequeueReusableCellWithIdentifier("SelectRouteCell") as! SelectRouteCell
		
		var crag = self.crags[indexPath.row]

		cell.cragNameLabel.text = crag["name"] as? String
		
		var routeCount: Int = crag["countRoute"] as! Int
		cell.climbNumberLabel.text = String(routeCount) + " routes"
		
		var cragGeoPoint: PFGeoPoint = PFGeoPoint()
		cragGeoPoint = crag["location"] as! PFGeoPoint
		
		var distance: Double!

		
		PFGeoPoint.geoPointForCurrentLocationInBackground({ (geoPoint:PFGeoPoint?, error:NSError?) -> Void in
			if error == nil {
				//do something with new geopoint
				println("current geoPoint = \(geoPoint)")
				println("crag geoPoint = \(cragGeoPoint)")
				
				distance = geoPoint?.distanceInMilesTo(cragGeoPoint)
				println("distance between geoPoints = \(distance)")
				cell.cragDistanceLabel.text = "\(round(distance)) miles"
			}
		})
		
		return cell
	}
	
//	func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//		var headerView = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 80))
//		headerView.backgroundColor = UIColor(white: 0.2, alpha: 0.5)
//		
//		var regionNameLabel = UILabel(frame:CGRect(x: 10, y: 0, width: 300, height: 40))
//		regionNameLabel.text = regions[section]
//		regionNameLabel.font = UIFont(name: "VarelaRound", size: 16)
//
//		
//		headerView.addSubview(regionNameLabel)
//		return headerView
//	}
//	
//	func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//		return 40
//	}
	
	func addCragPins() {
		
		//TODO: not working yet
		for index in 0...self.crags.count-1 {
			var crag = self.crags[index]
			var cragGeoPoint: PFGeoPoint = PFGeoPoint()
			cragGeoPoint = crag["location"] as! PFGeoPoint
			var cragLocation: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: cragGeoPoint.latitude, longitude: cragGeoPoint.longitude)
			
			var annotation = MKPointAnnotation()
			annotation.coordinate = cragLocation
			println("\(cragGeoPoint)")
			
			self.selectMapView.addAnnotation(annotation)
			
		}
	}
	
	func locationManager(manager:CLLocationManager, didUpdateLocations locations:[AnyObject]) {
		//		location = "\(locations[0])"
		myLocations.append(locations[0] as! CLLocation)
		
		let spanX = 0.01
		let spanY = 0.01
		var newRegion = MKCoordinateRegion(center: selectMapView.userLocation.coordinate, span: MKCoordinateSpanMake(spanX, spanY))
		selectMapView.setRegion(newRegion, animated: true)
		
	}
	
	func addCurrentLocationPin() {
		let annotation = MKPointAnnotation()
		var locationCoordinate = CLLocationCoordinate2DMake(39.3761, -104.8535)
		annotation.coordinate = locationCoordinate
		selectMapView.addAnnotation(annotation)
	}
	
	func mapView(mapView: MKMapView!, didSelectAnnotationView view: MKAnnotationView!) {
		//		UIAlertView(title: "tapped Annotation!", message: view.annotation.title, delegate: nil, cancelButtonTitle: "OK").show()
	}
	
	
	func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
		
		let reuseID = "myAnnotationView"
		var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseID)
		if (annotationView == nil) {
			annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseID)
		}
		else {
			annotationView.annotation = annotation
		}
		
		annotationView.image = UIImage(named: "custom_pin")
		annotationView.canShowCallout = true;
		
		
		return annotationView
	}

	
	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		print(self.contentView.frame.origin.y)

		UIView.animateWithDuration(0.3, delay: 0.3, options: .CurveEaseOut, animations: {
			self.contentView.frame.origin.y = 490
			}) { (Bool) -> Void in
				self.contentView.frame.origin.y = 0
				
				self.cragName = self.crags[indexPath.row]["name"] as? String
				if(self.delegate != nil){
					self.delegate?.selectRoute(self, text: self.cragName)
				}
				self.view.removeFromSuperview()
		}
		
		
//		self.view.removeFromSuperview()
//

	}

}
