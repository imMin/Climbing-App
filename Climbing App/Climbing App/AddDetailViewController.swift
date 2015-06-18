//
//  AddDetailViewController.swift
//  Climbing App
//
//  Created by Min Hu on 6/15/15.
//  Copyright (c) 2015 Min Hu. All rights reserved.
//

import UIKit

class AddDetailViewController: UIViewController {

	
	var routeName: String!
	var selectedLevel : Int!
	var level: String!
	@IBOutlet weak var routeNameLabel: UILabel!
	@IBOutlet weak var levelLabel: UILabel!
	@IBOutlet weak var levelScrollView: UIScrollView!
	@IBOutlet weak var touchableView: UIView!
	var levels = ["5.6", "5.7", "5.8", "5.9", "5.10a", "5.10b", "5.10c", "5.10d", "5.11a", "5.11b", "5.11c", "5.11d", "5.12a", "5.12b", "5.12c", "5.12d", "5.13a", "5.13b", "5.13c", "5.14d"]
	
	
    override func viewDidLoad() {
        super.viewDidLoad()
		println(levelLabel)
		routeNameLabel.text = routeName
		levelLabel.text = level
		levelScrollView.contentSize = CGSizeMake(2160, 80)
		levelScrollView.clipsToBounds = false
		touchableView.addGestureRecognizer(levelScrollView.panGestureRecognizer)
		findSelectedlevel()
		println(selectedLevel)
		levelScrollView.contentOffset.x = CGFloat(116 * (selectedLevel-1))
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	@IBAction func didPressCancelButton(sender: AnyObject) {
		dismissViewControllerAnimated(true, completion: nil)
	}
	
	func findSelectedlevel(){
		for (var i = 0; i < levels.count; i++){
			if levels[i] == levelLabel.text {
				selectedLevel = i
			}
		}
	}
	

}
