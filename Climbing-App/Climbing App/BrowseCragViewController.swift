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

let didSaveNewRegion = "did you just save a new region?"

let kDidSaveCrag = "kDidSaveCrag"


class BrowseCragViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate, MKMapViewDelegate {
	
    @IBOutlet weak var mapContainer: UIView!
	@IBOutlet weak var cragMapView: MKMapView!
	@IBOutlet weak var cragTableView: UITableView!
    @IBOutlet weak var regionNameLabel: UILabel!
	@IBOutlet weak var progressView: UIView!
	@IBOutlet weak var saveLabel: UILabel!
	@IBOutlet weak var saveIcon: UIImageView!
	
	@IBOutlet weak var savedIcon: UIImageView!
    @IBOutlet weak var regionView: UIImageView!
	@IBOutlet weak var topBar: UIView!
	
    @IBOutlet weak var regionDescription: UIView!
    
    
    var descriptionX: CGFloat!
    var mapOriginalFrame: CGRect!
    var image: UIImage!
	var region: Region!
	var manager:CLLocationManager!
	var myLocations:[CLLocation] = []
	var location: CLLocation!
	var saved = false
	
	var cragNames = ["Lyme Disease Rock", "Indian Rock", "Waterfall Cliffs", "Billy Goat Rock", "cragName5", "cragName6", "cragName7", "cragName8", "cragName9", "cragName10"]
	
	var cragDistances = ["0.3mi", "0.5mi", "0.7mi", "1.5mi", "1.8mi", "2.1mi", "14mi", "15mi", "18mi", "22mi", "0.3mi", "0.5mi", "0.7mi", "1.5mi", "1.8mi", "2.1mi", "14mi", "15mi", "18mi", "22mi", "0.3mi", "0.5mi", "0.7mi"]
	
	var climbNumbers = ["3 routes", "5 routes", "4 routes", "5 routes", "7 routes", "2 routes", "3 routes", "4 routes", "3 routes", "2 routes", "3 routes", "5 routes", "4 routes", "5 routes", "7 routes", "2 routes", "3 routes", "4 routes", "3 routes", "2 routes", "3 routes", "5 routes", "4 routes"]
	
	var regions = ["Castle Rock"]
    
    var crags: [PFObject] = [PFObject]()
    var currentLocation: CLLocation!
    var locManager: CLLocationManager!
    
    var mapCenterY: CGFloat!

	
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        descriptionX = regionDescription.center.x
//        regionDescription.alpha = 0
		
		guideUnsaved()
		
		NSNotificationCenter.defaultCenter().addObserver(self, selector: "guideSaved", name: didSaveNewLog, object: nil)

		progressView.alpha = 0 
        regionNameLabel.text = region.name
		
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
        
		
		var coordRegion : MKCoordinateRegion
		coordRegion = MKCoordinateRegionMake(CLLocationCoordinate2DMake(37.2306, -122.0957), MKCoordinateSpanMake(0.4, 0.4))
		coordRegion = cragMapView.regionThatFits(coordRegion)
		cragMapView.setRegion(coordRegion, animated: false)
		
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
		
		
		if NSUserDefaults.standardUserDefaults().boolForKey(kDidSaveCrag) {
			guideSaved()
			
		}
        
        mapCenterY = cragMapView.center.y
        
        //Visual stuff for crag map
        cragMapView.center.y = -300
        cragMapView.layer.cornerRadius = 3
        mapContainer.alpha = 0
    }
    

    func fetchCrags() {
        println("fetched crags")
        
        var query = PFQuery(className: "Crag")
        query.orderByAscending("createdAt")
        query.findObjectsInBackgroundWithBlock { (objects:[AnyObject]?, error:NSError?) -> Void in
            self.crags = objects as! [PFObject]
            self.cragTableView.reloadData()
            
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
        
        delay(2) {
            println("crags.count = \(self.crags.count)")
            self.addCragPins()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.crags.count
	}

	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: BrowseCragCell!
        cell = self.cragTableView.dequeueReusableCellWithIdentifier("BrowseCragCell") as! BrowseCragCell
            
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
				cell.selectionStyle = UITableViewCellSelectionStyle.None

            }
        })
            
 
        
        return cell

	}
    
    func addCragPins() {
//        var annotations: [MKPointAnnotation!]
//        var coordinates: [CLLocationCoordinate2D!]
//        
//        coordinates = [CLLocationCoordinate2DMake(37.2306, -122.0957),CLLocationCoordinate2DMake(37.865101, -119.538329),CLLocationCoordinate2DMake(36.778261, -119.417932),CLLocationCoordinate2DMake(37.881591, -121.914153),CLLocationCoordinate2DMake(38.669351, -122.633319)]
//        
//        for index in 0..<coordinates.count{
//            let annotation = MKPointAnnotation()
//            annotation.coordinate = coordinates[index]
//            //			annotations.append(annotation)
//            cragMapView.addAnnotation(annotation)
        
        //TODO: not working always yet
        for index in 0..<self.crags.count {
            var crag = self.crags[index]
            var cragGeoPoint: PFGeoPoint = PFGeoPoint()
            cragGeoPoint = crag["location"] as! PFGeoPoint
            var cragLocation: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: cragGeoPoint.latitude, longitude: cragGeoPoint.longitude)
            
            var annotation = MKPointAnnotation()
            annotation.title = crag["name"] as! String
            annotation.coordinate = cragLocation
            println("\(cragGeoPoint)")
            
            self.cragMapView.addAnnotation(annotation)

        }
    }
    
//    override func viewDidAppear(animated: Bool) {
//        regionDescription.center.x = 500
//        regionDescription.alpha = 0
//        UIView.animateWithDuration(0.5, animations: { () -> Void in
//            self.regionDescription.alpha = 1
//            self.regionDescription.center.x = self.descriptionX
//        })
//    }
    
    
    //ANIMATIONS
    @IBAction func onTapDirections(sender: AnyObject) {
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.cragMapView.center.y = self.mapCenterY
            self.mapContainer.alpha = 1
        })
    }
	
    @IBAction func onCloseMap(sender: AnyObject) {
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.mapContainer.alpha = 0
        })
    }
    
    
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if (segue.identifier == "cragDetailSegue") {
			
			// initialize new view controller and cast it as your view controller
			var viewController = segue.destinationViewController as! CragDetailViewController
			
			let indexPath : NSIndexPath = self.cragTableView.indexPathForSelectedRow()!
			
			// your new view controller should have property that will store passed value
            
            //passing actual clicked crag name
            viewController.cragName = crags[indexPath.row]["name"] as! String
            
            //placeholder values below
			viewController.cragDistance = cragDistances[indexPath.row]
			viewController.climbNumber = climbNumbers[indexPath.row]
		}
	}
	
	@IBAction func didPressBackButton(sender: AnyObject) {
		navigationController?.popViewControllerAnimated(true)
	}
    
    @IBAction func didPressSaveButton(sender: AnyObject) {
        Region.savedRegions.append(region)
//		NSNotificationCenter.defaultCenter().postNotificationName(didSaveNewRegion, object: self)
		progressView.alpha = 1
		
		UIView.animateWithDuration(2, delay: 0.0, options: .CurveEaseOut, animations: { () -> Void in
			self.progressView.frame.size.width = CGFloat(320)
		}) { (Bool) -> Void in
			UIView.animateWithDuration(0.1, animations: { () -> Void in
				self.progressView.alpha = 0
			}, completion: { (Bool) -> Void in
				self.progressView.frame.size.width = 1
				self.guideSaved()
				NSNotificationCenter.defaultCenter().postNotificationName(didSaveNewRegion, object: self)
			})
		}
		
		saved = true
		
		if NSUserDefaults.standardUserDefaults().boolForKey(kDidSaveCrag) {
			NSUserDefaults.standardUserDefaults().setBool(false, forKey: kDidSaveCrag)
			guideUnsaved()
		}
		else {
			NSUserDefaults.standardUserDefaults().setBool(true, forKey: kDidSaveCrag)
		}
    }
	
	func locationManager(manager:CLLocationManager, didUpdateLocations locations:[AnyObject]) {
		//		location = "\(locations[0])"
		myLocations.append(locations[0] as! CLLocation)
		
		let spanX = 1.1
		let spanY = 1.1
		var newRegion = MKCoordinateRegion(center: cragMapView.userLocation.coordinate, span: MKCoordinateSpanMake(spanX, spanY))
		cragMapView.setRegion(newRegion, animated: true)

	}
	
	func addCurrentLocationPin() {
		let annotation = MKPointAnnotation()
		var locationCoordinate = CLLocationCoordinate2DMake(37.2306, -122.0957)
		annotation.coordinate = locationCoordinate
		cragMapView.addAnnotation(annotation)
	}
	
	func mapView(mapView: MKMapView!, didSelectAnnotationView view: MKAnnotationView!) {
//		UIAlertView(title: "tapped Annotation!", message: view.annotation.title, delegate: nil, cancelButtonTitle: "OK").show()
	}
    
    func mapView(mapView: MKMapView!, didUpdateUserLocation userLocation: MKUserLocation!) {
        var coordRegion : MKCoordinateRegion
        coordRegion = MKCoordinateRegionMake(CLLocationCoordinate2DMake(37.2306, -122.0957), MKCoordinateSpanMake(1.1, 1.1))
        coordRegion = cragMapView.regionThatFits(coordRegion)
        cragMapView.setRegion(coordRegion, animated: false)

    }
	
	func guideSaved(){
		self.saveLabel.text = "Saved"
		self.saveIcon.alpha = 0
		self.savedIcon.alpha = 1
	}
	
	func guideUnsaved(){
		self.saveLabel.text = "Save"
		self.saveIcon.alpha = 1
		self.savedIcon.alpha = 0
	}
	
	func scrollViewDidScroll(scrollView: UIScrollView) {
		if scrollView.contentOffset.y > 34 {
			UIView.animateWithDuration(0.3, animations: { () -> Void in
				self.topBar.alpha = 1
			})
			
//			if self.topBar.alpha != 1 {
//				self.topBar.alpha += 0.1
//			}
			

		}
		else {
			UIView.animateWithDuration(0.3, animations: { () -> Void in
				self.topBar.alpha = 0
			})
			
//			if self.topBar.alpha != 0 {
//				self.topBar.alpha -= 0.1
//			}
			
		}
	}
	
	
//	func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
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
////		annotationView.image = UIImage(named: "custom_pin")
//		annotationView.canShowCallout = true;
//
//		
//		return annotationView
//	}

}
