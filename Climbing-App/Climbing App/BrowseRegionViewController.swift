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

	var regions = ["Castle Rock", "Mickey's Beach", "Yosemite", "Mt. Diablo", "Mt. St. Helena"]
	
	var distances = ["5 mi", "135 mi", "15 mi", "20 mi", "20 mi"]
    
	var climbNumbers = ["32 routes", "37 routes", "200 routes", "232 routes", "117 routes"]
    
    var regionImages = ["castlerock-region-image", "mickeys-region-image", "mtdiablo-region-image", "yosemite-region-image", "mtsthelena-region-image"]
    
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
		
        //Content of cell
		cell.regionNameLabel.text = regions[indexPath.row]
		cell.climbNumberLabel.text = climbNumbers[indexPath.row]
		cell.distanceLabel.text = distances[indexPath.row]
        cell.regionView.image = UIImage(named: "\(regionImages[indexPath.row])")
        
        
        //Visual style of cell
        cell.layer.cornerRadius = 4
        UIColor(red: 234/255, green: 235/255, blue: 234/255, alpha: 1)
        cell.layer.borderColor = UIColor(red: 234/255, green: 235/255, blue: 234/255, alpha: 1).CGColor
        cell.layer.borderWidth = 1
        cell.regionCellContent.layer.shadowColor = UIColor.blackColor().CGColor
        cell.regionCellContent.layer.shadowOffset = CGSizeMake(1, 3)
        cell.regionCellContent.layer.shadowOpacity = 0.5
        cell.layer.backgroundColor = UIColor.clearColor().CGColor
        
        return cell
    
        
	}
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if (segue.identifier == "regionDetailSegue"){

		var viewController = segue.destinationViewController as! BrowseCragViewController
		
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


