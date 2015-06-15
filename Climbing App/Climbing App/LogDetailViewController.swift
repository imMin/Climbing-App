//
//  LogDetailViewController.swift
//  Climbing App
//
//  Created by Min Hu on 6/14/15.
//  Copyright (c) 2015 Min Hu. All rights reserved.
//

import UIKit

class LogDetailViewController: UIViewController {
	
	var level : String!
	var location : String!
	
	
	@IBOutlet weak var levelLabel: UILabel!
	@IBOutlet weak var locationLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
		
		
		self.levelLabel.text = level
		self.locationLabel.text = location

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
