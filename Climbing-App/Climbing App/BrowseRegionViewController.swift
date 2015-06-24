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

class Region {
    var name: String?
    var distanceString: String?
    var countString: String?
    var imageName: String?
    
    static var allRegions: [Region] {
        var allRegions = [Region]()
        
        var castleRock = Region()
        castleRock.name = "Castle Rock"
        castleRock.distanceString = "5 mi"
        castleRock.countString = "32 routes"
        castleRock.imageName = "castlerock-region-image"
        
        var mBeach = Region()
        mBeach.name = "Mickey's Beach"
        mBeach.distanceString = "135 mi"
        mBeach.countString = "37 routes"
        mBeach.imageName = "mickeys-region-image"
        
        var yose = Region()
        yose.name = "Yosemite"
        yose.distanceString = "15 mi"
        yose.countString = "200 routes"
        yose.imageName = "yosemite-region-image"
        
        var mDiablo = Region()
        mDiablo.name = "Mt. Diablo"
        mDiablo.distanceString = "20 mi"
        mDiablo.countString = "232 routes"
        mDiablo.imageName = "mtdiablo-region-image"
        
        var mSH = Region()
        mSH.name = "Mt. St. Helena"
        mSH.distanceString = "20 mi"
        mSH.countString = "117 routes"
        mSH.imageName = "mtsthelena-region-image"
        
        allRegions.append(castleRock)
        allRegions.append(mBeach)
        allRegions.append(yose)
        allRegions.append(mDiablo)
        allRegions.append(mSH)
        
        return allRegions
    }
    
    static var savedRegions = [Region]() {
        didSet {
            println("saved a fucking crag")
        }
    }
}

class BrowseRegionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, CLLocationManagerDelegate, MKMapViewDelegate
{

//	var regions = ["Castle Rock", "Mickey's Beach", "Yosemite", "Mt. Diablo", "Mt. St. Helena"]
    
    var regions = Region.allRegions
	
	var distances = ["5 mi", "135 mi", "15 mi", "20 mi", "20 mi"]
    
	var climbNumbers = ["32 routes", "37 routes", "200 routes", "232 routes", "117 routes"]
    
    var regionImages = ["castlerock-region-image", "mickeys-region-image", "mtdiablo-region-image", "yosemite-region-image", "mtsthelena-region-image"]
    
	var manager:CLLocationManager!
	var myLocations:[CLLocation] = []
	var location: CLLocation!
	
	@IBOutlet weak var regionCollectionView: UICollectionView!
	
	@IBOutlet weak var regionMapView: MKMapView!
    
	var currentLocation: CLLocation!
	var locManager: CLLocationManager!
	
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
		region = MKCoordinateRegionMake(CLLocationCoordinate2DMake(37.2306, -122.0957), MKCoordinateSpanMake(0.4, 0.4))
		region = regionMapView.regionThatFits(region)
		regionMapView.setRegion(region, animated: false)
		
		//create an instance of CLLocationManager and Request Authorization
		locManager = CLLocationManager()
		locManager.requestWhenInUseAuthorization()
		
		//check if user allows authorization
		if( CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedWhenInUse ||
			CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedAlways){
				currentLocation = locManager.location
		}

		
		addPin()
		
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
//		cell.regionNameLabel.text = regions[indexPath.row]
//		cell.climbNumberLabel.text = climbNumbers[indexPath.row]
//		cell.distanceLabel.text = distances[indexPath.row]
//        cell.regionView.image = UIImage(named: "\(regionImages[indexPath.row])")
        
        var cellRegion = regions[indexPath.row]
        
        cell.region = cellRegion
        cell.regionNameLabel.text = cellRegion.name
        cell.climbNumberLabel.text = cellRegion.countString
        cell.distanceLabel.text = cellRegion.distanceString
        cell.regionView.image = UIImage(named: cellRegion.imageName!)
        
        //Visual style of cell
        cell.layer.cornerRadius = 4
        UIColor(red: 234/255, green: 235/255, blue: 234/255, alpha: 1)
        cell.layer.borderColor = UIColor(red: 234/255, green: 235/255, blue: 234/255, alpha: 1).CGColor
        cell.layer.borderWidth = 1
        cell.regionCellContent.layer.shadowColor = UIColor.blackColor().CGColor
        cell.regionCellContent.layer.shadowOffset = CGSizeMake(1, 3)
        cell.regionCellContent.layer.shadowOpacity = 0.1
        cell.layer.backgroundColor = UIColor.clearColor().CGColor
        
        return cell
    
        
	}
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

		var viewController = segue.destinationViewController as! BrowseCragViewController
        viewController.region = (sender as! RegionCell).region
		
	}
	
	func locationManager(manager:CLLocationManager, didUpdateLocations locations:[AnyObject]) {
//		location = "\(locations[0])"
		myLocations.append(locations[0] as! CLLocation)
		
		let spanX = 5.0
		let spanY = 5.0
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
		var annotations: [MKPointAnnotation!]
		var coordinates: [CLLocationCoordinate2D!]
		
		coordinates = [CLLocationCoordinate2DMake(37.2306, -122.0957),CLLocationCoordinate2DMake(37.865101, -119.538329),CLLocationCoordinate2DMake(36.778261, -119.417932),CLLocationCoordinate2DMake(37.881591, -121.914153),CLLocationCoordinate2DMake(38.669351, -122.633319)]
		
		for (var i = 0; i < 5; i++){
			let annotation = MKPointAnnotation()
			annotation.coordinate = coordinates[i]
			//			annotations.append(annotation)
			regionMapView.addAnnotation(annotation)
		}
	}

	
	func mapView(mapView: MKMapView!, didSelectAnnotationView view: MKAnnotationView!) {
		//		UIAlertView(title: "tapped Annotation!", message: view.annotation.title, delegate: nil, cancelButtonTitle: "OK").show()
	}
	
	func addCurrentLocationPin() {
		let annotation = MKPointAnnotation()
		var locationCoordinate = CLLocationCoordinate2DMake(37.2306, -122.0957)
		annotation.coordinate = locationCoordinate
		regionMapView.addAnnotation(annotation)
	}
	
//	func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
//		if annotation.isKindOfClass(MKUserLocation) {
//			return nil
//		}
//		
//		let reuseID = "myAnnotationView"
//		var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseID)
//		if (annotationView == nil) {
//			annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseID)
//		}
//		else {
//			annotationView.annotation = annotation
//		}
//		
//		annotationView.image = UIImage(named: "custom_pin")
//		annotationView.canShowCallout = true;
//		
//		
//		return annotationView
//	}

//	
//	func mapView(mapView: MKMapView!, didSelectAnnotationView view: MKAnnotationView!) {
//		//		UIAlertView(title: "tapped Annotation!", message: view.annotation.title, delegate: nil, cancelButtonTitle: "OK").show()
//	}
	
	
}


