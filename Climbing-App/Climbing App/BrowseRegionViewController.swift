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
        castleRock.imageName = "castle-rock-hero"
        
        var mBeach = Region()
        mBeach.name = "Mickey's Beach"
        mBeach.distanceString = "135 mi"
        mBeach.countString = "37 routes"
        mBeach.imageName = "mickeys-hero"
        
        var mDiablo = Region()
        mDiablo.name = "Mt. Diablo"
        mDiablo.distanceString = "20 mi"
        mDiablo.countString = "232 routes"
        mDiablo.imageName = "mtdiablo-hero"
        
        var mSH = Region()
        mSH.name = "Mt. St. Helena"
        mSH.distanceString = "20 mi"
        mSH.countString = "117 routes"
        mSH.imageName = "mtsthelena-hero"
        
        var pinnacles = Region()
        pinnacles.name = "Pinnacles"
        pinnacles.distanceString = "20 mi"
        pinnacles.countString = "117 routes"
        pinnacles.imageName = "pinnacles-hero"
        
        var yose = Region()
        yose.name = "Yosemite"
        yose.distanceString = "15 mi"
        yose.countString = "200 routes"
        yose.imageName = "yosemite-hero"
        
        var bishop = Region()
        bishop.name = "Bishop"
        bishop.distanceString = "20 mi"
        bishop.countString = "117 routes"
        bishop.imageName = "bishop-hero"
        
        allRegions.append(castleRock)
        allRegions.append(mBeach)
        allRegions.append(mDiablo)
        allRegions.append(mSH)
        allRegions.append(pinnacles)
        allRegions.append(yose)
        allRegions.append(bishop)
        
        return allRegions
    }
    
    static var savedRegions = [Region]() {
        didSet {
            println("saved a crag")
        }
    }
}

class BrowseRegionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, CLLocationManagerDelegate, MKMapViewDelegate
{
    
    var regions = Region.allRegions
    
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
		
//		regionCollectionView.allowsSelection = false
		
		
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
        
        var cellRegion = regions[indexPath.row]
        
        cell.region = cellRegion
        cell.regionNameLabel.text = cellRegion.name
        cell.climbNumberLabel.text = cellRegion.countString
        cell.distanceLabel.text = cellRegion.distanceString
        cell.regionView.image = UIImage(named: cellRegion.imageName!)
        
        //Visual style of cell
        cell.layer.cornerRadius = 2

		
        return cell
    
        
	}
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

		var viewController = segue.destinationViewController as! BrowseCragViewController
        viewController.region = (sender as! RegionCell).region
        viewController.image = (sender as! RegionCell).regionView.image
		
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
    
    func mapView(mapView: MKMapView!, didUpdateUserLocation userLocation: MKUserLocation!) {
        var coordRegion : MKCoordinateRegion
        coordRegion = MKCoordinateRegionMake(CLLocationCoordinate2DMake(37.2306, -122.0957), MKCoordinateSpanMake(5.0, 5.0))
        coordRegion = regionMapView.regionThatFits(coordRegion)
        regionMapView.setRegion(coordRegion, animated: false)
        
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


