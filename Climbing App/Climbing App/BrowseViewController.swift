//
//  BrowseViewController.swift
//  Climbing App
//
//  Created by Min Hu on 6/12/15.
//  Copyright (c) 2015 Min Hu. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class BrowseViewController: UIViewController, CLLocationManagerDelegate{
	
	@IBOutlet weak var locationMapView: MKMapView!
	@IBOutlet weak var cragTableView: UITableView!
	
	
	var locationManager: CLLocationManager!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		locationMapView.showsUserLocation = true
		
		if (CLLocationManager.locationServicesEnabled())
		{
			locationManager = CLLocationManager()
			locationManager.delegate = self
			locationManager.desiredAccuracy = kCLLocationAccuracyBest
			locationManager.requestAlwaysAuthorization()
			locationManager.startUpdatingLocation()
		}
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


}
