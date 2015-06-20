//
//  BrowseRegionViewController.swift
//  Climbing App
//
//  Created by Min Hu on 6/15/15.
//  Copyright (c) 2015 Min Hu. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class BrowseRegionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, CLLocationManagerDelegate, MKMapViewDelegate
{

	var regions = ["Castle Rock North", "Castle Rock South", "Yosemite Valley", "Yosemite Fall", "El Capitain", "Mt Diablo"]
	
	var distances = ["5 mi", "24 mi", "135 mi", "200 mi", "234 mi", "300 mi"]
	var climbNumbers = ["32 routes", "37 routes", "200 routes", "232 routes", "323 routes", "30 routes"]
	var manager:CLLocationManager!
	var myLocations:[CLLocation] = []
	var location: CLLocation!
	
	@IBOutlet weak var regionCollectionView: UICollectionView!
	
	@IBOutlet weak var regionMapView: MKMapView!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		regionCollectionView.delegate = self
		regionCollectionView.dataSource = self

		//Set up Location Manager
		manager = CLLocationManager()
		manager.delegate = self
		manager.desiredAccuracy = kCLLocationAccuracyBest
		manager.requestAlwaysAuthorization()
		manager.startUpdatingLocation()
		
		//Set up Map View
		regionMapView.delegate = self
		regionMapView.mapType = MKMapType.Hybrid
		regionMapView.showsPointsOfInterest = false
		regionMapView.showsUserLocation = true
		
		var region : MKCoordinateRegion
		region = MKCoordinateRegionMake(CLLocationCoordinate2DMake(39.3761, -104.8535), MKCoordinateSpanMake(0.4, 0.4))
		region = regionMapView.regionThatFits(region)
		regionMapView.setRegion(region, animated: false)
		
//		regionMapView.setCenterCoordinate(CLLocationCoordinate2DMake(, ), animated: true)
		
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
	func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
		return 1
	}
	
	
	
	func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return regions.count
	}
	
	func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
		let cell = regionCollectionView.dequeueReusableCellWithReuseIdentifier("RegionCell",
		forIndexPath: indexPath) as! RegionCell
		
		cell.regionNameLabel.text = regions[indexPath.row]
		cell.climbNumberLabel.text = climbNumbers[indexPath.row]
		cell.distanceLabel.text = distances[indexPath.row]
		return cell
	}
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if (segue.identifier == "regionDetailSegue"){
		
		// initialize new view controller and cast it as your view controller
		var viewController = segue.destinationViewController as! BrowseCragViewController
		
//		let indexPath : NSIndexPath = self.regionCollectionView.indexPathsForSelectedItems()
//		
//		// your new view controller should have property that will store passed value
//		viewController.region = regions[indexPath.row]
	}
	}
	
	func locationManager(manager:CLLocationManager, didUpdateLocations locations:[AnyObject]) {
//		location = "\(locations[0])"
		myLocations.append(locations[0] as! CLLocation)
		
		let spanX = 0.4
		let spanY = 0.4
		var newRegion = MKCoordinateRegion(center: regionMapView.userLocation.coordinate, span: MKCoordinateSpanMake(spanX, spanY))
		regionMapView.setRegion(newRegion, animated: true)
		
//		if (myLocations.count > 1){
//			var sourceIndex = myLocations.count - 1
//			var destinationIndex = myLocations.count - 2
//			
//			let c1 = myLocations[sourceIndex].coordinate
//			let c2 = myLocations[destinationIndex].coordinate
//			var a = [c1, c2]
//			var polyline = MKPolyline(coordinates: &a, count: a.count)
//			theMap.addOverlay(polyline)
//		}
	}

}


