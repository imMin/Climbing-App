//
//  MyLogViewController.swift
//  Climbing App
//
//  Created by Min Hu on 6/12/15.
//  Copyright (c) 2015 Min Hu. All rights reserved.
//

import UIKit

class MyLogViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

	@IBOutlet weak var logTableView: UITableView!
    @IBOutlet weak var profileView: UIView!
	@IBOutlet weak var avatar: UIImageView!
	@IBOutlet weak var tinyHeader: UIView!
	@IBOutlet weak var navTitle: UILabel!
	
	var dates: [String] = ["date"]
	var climbInDates: [Int] = []
	var levels: [String] = []
	var locations: [String] = []
	var types: [String] = []
	var styles: [String] = []
	var logs: [PFObject]! = []
	
	var lastScrollY: CGFloat!
	
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		self.logTableView.delegate = self
		self.logTableView.dataSource = self
		self.logTableView.estimatedRowHeight = 69;
		println(self.profileView.frame.height)
		println(self.logTableView.contentSize.height)
		
		fetchData()
		
		NSNotificationCenter.defaultCenter().addObserver(self, selector: "insertData", name: didSaveNewLog, object: nil)
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
	
	
	func fetchData() {
		
		dates = ["date"]
		climbInDates = []
		levels = []
		locations = []
		types = []
		styles = []
		logs = []
		
		var query = PFQuery(className: "Log")
		query.orderByDescending("date")
		
		
		// date formatter
		let dateFormatter = NSDateFormatter()
		dateFormatter.dateFormat = "MMM dd, YYYY"
		
		logs = query.findObjects() as! [PFObject]
		self.dates[0] = dateFormatter.stringFromDate(self.logs[0]["date"] as! NSDate)
		
		var count = 0
		
		for (var i = 0; i < self.logs.count; i++){
			var nextDate = dateFormatter.stringFromDate(self.logs[i]["date"] as! NSDate)
			
			if (nextDate != self.dates[self.dates.count-1]){
				self.dates.append(nextDate)
				self.climbInDates.append(count)
				count = 1
			}
			else {
				count++
			}
			
			self.levels.append(self.logs[i]["level"] as! String)
			self.locations.append(self.logs[i]["location"] as! String)
			self.types.append(self.logs[i]["type"] as! String)
			self.styles.append(self.logs[i]["style"] as! String)
		}
		
		self.climbInDates.append(count)
	}
	
	func insertData() {
		fetchData()
		
		logTableView.reloadData()
		
		var newIndexPath = NSIndexPath(forRow: 0, inSection: 0)
		self.logTableView.selectRowAtIndexPath(newIndexPath, animated: false, scrollPosition: UITableViewScrollPosition.Top)
		
		delay(0.5, { () -> () in
			self.logTableView.deselectRowAtIndexPath(newIndexPath, animated: true)
		})
	}
	
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		
		return climbInDates[section]
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
	
	
	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		tableView.deselectRowAtIndexPath(indexPath, animated: false)
	}
	
	func scrollViewWillBeginDragging(scrollView: UIScrollView) {
		lastScrollY = scrollView.contentOffset.y
	}
	
    func scrollViewDidScroll(scrollView: UIScrollView) {
		println(scrollView.contentOffset.y)
		var v = scrollView.contentOffset.y/200
		
		if scrollView.contentOffset.y == 0 {
			avatar.transform = CGAffineTransformIdentity
		}
		else if scrollView.contentOffset.y > 0 {
			avatar.transform = CGAffineTransformMakeScale(1-v, 1-v)
		}
		else {
			avatar.transform = CGAffineTransformMakeScale(1-v, 1-v)
		}
		
		
		if lastScrollY < scrollView.contentOffset.y && scrollView.contentOffset.y > 82 {
			
			if navTitle.alpha > 0 {
				navTitle.alpha -= 0.1
				tinyHeader.alpha += 0.1
			}
			
			if tinyHeader.frame.origin.y != 22 {
				tinyHeader.frame.origin.y -= 1
			}
		}
		else if lastScrollY > scrollView.contentOffset.y && scrollView.contentOffset.y < 200 {
			
			if navTitle.alpha < 1 {
				navTitle.alpha += 0.1
				tinyHeader.alpha -= 0.1
			}
			
			if tinyHeader.frame.origin.y != 62 {
				tinyHeader.frame.origin.y += 1
			}
		}
    }
	
	
	
	
}
