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
	
	var cragNames = ["routeName1", "routeName2", "routeName3", "routeName4", "routeName5"]
//	var routeLevels = ["5.9", "5.10a", "5.11a", "5.12b", "5.10c", "5.9", "5.10a", "5.11a", "5.12b", "5.10c"]
//	
	var cragDistances = ["0.3mi", "0.5mi", "0.7mi", "1.5mi", "2.0mi"]
	
	var climbNumbers = ["3 routes", "5 routes", "4 routes", "5 routes", "4 routes"]
	
	var regions = ["Region one", "Region two", "Region three"]
	
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
		return cragNames.count
	}
	
	func tableView(tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int {
		return regions.count
	}
	
	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return regions.count
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		var cell = selectTableView.dequeueReusableCellWithIdentifier("SelectRouteCell") as! SelectRouteCell
		
		cell.cragNameLabel.text = cragNames[indexPath.row]
		cell.climbNumberLabel.text = climbNumbers[indexPath.row]
		cell.cragDistanceLabel.text = cragDistances[indexPath.row]
		
		return cell
	}
	
	func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		var headerView = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 80))
		headerView.backgroundColor = UIColor(white: 0.2, alpha: 0.5)
		
		var regionNameLabel = UILabel(frame:CGRect(x: 10, y: 0, width: 300, height: 40))
		regionNameLabel.text = regions[section]
		regionNameLabel.font = UIFont(name: "VarelaRound", size: 16)

		
		headerView.addSubview(regionNameLabel)
		return headerView
	}
	
	func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 40
	}
	
	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		print(self.contentView.frame.origin.y)

		UIView.animateWithDuration(0.3, delay: 0.3, options: .CurveEaseOut, animations: {
			self.contentView.frame.origin.y = 490
			}) { (Bool) -> Void in
				self.contentView.frame.origin.y = 0
				self.cragName = self.cragNames[indexPath.row]
				if(self.delegate != nil){
					self.delegate?.selectRoute(self, text: self.cragName)
				}
				self.view.removeFromSuperview()
		}
		
		
//		self.view.removeFromSuperview()
//

	}

}
