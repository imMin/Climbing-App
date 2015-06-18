//
//  RouteDetailViewController.swift
//  Climbing App
//
//  Created by Min Hu on 6/16/15.
//  Copyright (c) 2015 Min Hu. All rights reserved.
//

import UIKit

class RouteDetailViewController: UIViewController {
	
	var routeName: String!
	var level: String!
	var type: String!
	var distance: String!
	var climb: String!
	
	
	@IBOutlet weak var routeNameLabel: UILabel!
	@IBOutlet weak var levelLabel: UILabel!
	@IBOutlet weak var typeLabel: UILabel!
	@IBOutlet weak var distanceLabel: UILabel!
	@IBOutlet weak var climbLabel: UILabel!
	
	
    override func viewDidLoad() {
        super.viewDidLoad()
		routeNameLabel.text = routeName
		levelLabel.text = level
		typeLabel.text = type
		distanceLabel.text = distance
		climbLabel.text = climb

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

	@IBAction func didPressBackButton(sender: AnyObject) {
		navigationController?.popViewControllerAnimated(true)
		
	}

}
