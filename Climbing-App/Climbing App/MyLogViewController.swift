//
//  MyLogViewController.swift
//  Climbing App
//
//  Created by Min Hu on 6/12/15.
//  Copyright (c) 2015 Min Hu. All rights reserved.
//

import UIKit

class MyLogViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

//	@IBOutlet weak var scrollView: UIScrollView!
	@IBOutlet weak var logTableView: UITableView!
    @IBOutlet weak var contentScrollView: UIScrollView!
    @IBOutlet weak var profileView: UIView!
	
	
	var levels = ["5.12c", "5.12a", "5.11a", "V3", "V4", "V5", "V5", "5.11a", "5.11c", "5.11a", "5.10d", "V3", "V2", "V3", "5.10d", "5.10c", "5.10c", "V2", "V2", "5.10a"]
	
	var locations = ["Mission Cliffs", "Mission Cliffs", "Mission Cliffs", "Planet Granite SF", "Planet Granite SF", "Planet Granite SF", "Planet Granite SF", "Mission Cliffs", "Mission Cliffs", "Mission Cliffs", "Mission Cliffs", "Dogpatch Boulders", "Dogpatch Boulders", "Dogpatch Boulders", "Mickey's Beach", "Mickey's Beach", "Mickey's Beach", "Mickey's Beach", "Mickey's Beach", "Mickey's Beach", "Ironworks"]
	
	var types = ["Top Rope", "Top Rope", "Lead", "", "", "", "", "Lead", "", "Top Rope","Lead", "Lead", "Lead", "", "","", "", "Top Rope", "Trad", "Top Rope","Top Rope"]
	
	var styles = ["On-sight", "Flash", "Flash", "Redpoint", "On-sight", "On-sight", "Flash", "Flash", "Redpoint", "On-sight", "On-sight", "Flash", "Flash", "Redpoint", "On-sight", "On-sight", "Flash", "Flash", "Redpoint", "On-sight", "On-sight"]
	
	var datesOld = ["June 14, 2015", "June 14, 2015", "June 12, 2015", "June 12, 2015", "May 15, 2015", "May 15, 2015", "May 15, 2015", "May 3, 2015", "May 3, 2015", "Apr 2, 2015", "Apr 2, 2015", "Apr 2, 2015", "Apr 2, 2015", "Mar 30, 2015", "Mar 30, 2015", "Mar 30, 2015", "Mar 19, 2015", "Mar 19, 2015", "Mar 19, 2015"]
	
//	var dates = ["June 14, 2015", "June 12, 2015", "May 15, 2015", "May 3, 2015", "Apr 2, 2015"]
	
	var dates: [String] = ["date"]
	
	var logs: [PFObject]! = []
	
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		var query = PFQuery(className: "Log")
		
		
		// date formatter
		let dateFormatter = NSDateFormatter()
		dateFormatter.dateFormat = "MMM dd, YYYY"
		
		query.findObjectsInBackgroundWithBlock { (results: [AnyObject]?, error: NSError?) -> Void in
			self.logs = results as! [PFObject]
			
			self.dates[0] = dateFormatter.stringFromDate(self.logs[0]["date"] as! NSDate)
			
			for (var i = 1; i < self.logs.count; i++){
				var nextDate = dateFormatter.stringFromDate(self.logs[i]["date"] as! NSDate)
				if (nextDate != self.dates[self.dates.count-1]){
					self.dates.append(nextDate)
				}
			}
			
			println(self.dates)
			
			self.logTableView.delegate = self
			self.logTableView.dataSource = self
			self.logTableView.estimatedRowHeight = 69;
			println(self.profileView.frame.height)
			println(self.logTableView.contentSize.height)
			self.contentScrollView.contentSize = CGSizeMake(320, self.profileView.frame.height + self.logTableView.frame.height)
			self.contentScrollView.delegate = self
			self.logTableView.scrollEnabled = false
		}
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 4
	}
	
	func tableView(tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int {

		return 5
	}
	
	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return dates.count
	}
	
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		
		var cell = logTableView.dequeueReusableCellWithIdentifier("LogCell") as! LogCell
		
		
		var log = logs[indexPath.row]
		cell.levelLabel.text = levels[indexPath.row]
		
		cell.locationLabel.text = locations[indexPath.row]
		cell.typeLabel.text = types[indexPath.row]
		cell.styleLabel.text = styles[indexPath.row]
		cell.accessoryType = UITableViewCellAccessoryType.None
        
		return cell
	}
	
	func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		var headerView = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 30))
		headerView.backgroundColor = UIColor(white: 0.95, alpha: 0.8)
		
		var label = UILabel(frame: CGRect(x: 20, y: 5, width: 300, height: 30))
		label.text = dates[section]
		label.font = UIFont(name: "VarelaRound", size: 12)
		headerView.addSubview(label)
		
		return headerView
	}
	
	func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 40
	}
	
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if(scrollView == self.contentScrollView){
            var contentSrollViewOffset = scrollView.contentOffset.y
            println(contentSrollViewOffset)
            if (contentSrollViewOffset > 181){
                self.logTableView.scrollEnabled = true
            }
            else if(contentSrollViewOffset < 181) {
                self.logTableView.scrollEnabled = false
            }
        }

    }
    
}
