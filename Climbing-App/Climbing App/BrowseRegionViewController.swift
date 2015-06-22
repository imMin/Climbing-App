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

	var regions = ["Castle Rock", "Yosemite", "Mickey's Beach", "Mt Diablo"]
	
	var distances = ["5 mi", "135 mi", "15 mi", "20 mi"]
	var climbNumbers = ["32 routes", "37 routes", "200 routes", "232 routes"]
	var manager:CLLocationManager!
	var myLocations:[CLLocation] = []
	var location: CLLocation!
	
	@IBOutlet weak var regionCollectionView: UICollectionView!
	
	@IBOutlet weak var regionMapView: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
		
//        regionContainer.layer.cornerRadius = 4
//        regionContainer.layer.borderColor = UIColor(rgba: "#ffcc00").CGColor 
        
        
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
        
        cell.layer.cornerRadius = 4
        cell.layer.shadowColor = UIColor.blackColor().CGColor
        cell.layer.shadowOffset = CGSizeMake(0, 3)
        cell.layer.shadowOpacity = 0.5
        
        return cell
        
        //ed: 225/255, green: 225/255, blue: 225/255, alpha: 1
        
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

	func addPin() {
		let annotation = MKPointAnnotation()
//		var castleRockCoordinate = CLLocationCoordinate2DMake(39.3761, -104.8535)
		var yosemiteCoordinate = CLLocationCoordinate2DMake(37.865101, -119.538329)
//		annotation.coordinate = castleRockCoordinate
		annotation.coordinate = yosemiteCoordinate
		regionMapView.addAnnotation(annotation)
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

	
}


