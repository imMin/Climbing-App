//
//  SavedViewController.swift
//  Climbing App
//
//  Created by Min Hu on 6/12/15.
//  Copyright (c) 2015 Min Hu. All rights reserved.
//

import UIKit

class SavedViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var regionCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        regionCollectionView.delegate = self
        regionCollectionView.dataSource = self
    }
    
    override func viewDidAppear(animated: Bool) {
        regionCollectionView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK - UICollectionViewDataSource
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Region.savedRegions.count
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = regionCollectionView.dequeueReusableCellWithReuseIdentifier("RegionCell",
            forIndexPath: indexPath) as! RegionCell
        
        //Content of cell
        //		cell.regionNameLabel.text = regions[indexPath.row]
        //		cell.climbNumberLabel.text = climbNumbers[indexPath.row]
        //		cell.distanceLabel.text = distances[indexPath.row]
        //        cell.regionView.image = UIImage(named: "\(regionImages[indexPath.row])")
        
        var cellRegion = Region.savedRegions[indexPath.row]
        
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
        cell.regionCellContent.layer.shadowOpacity = 0.5
        cell.layer.backgroundColor = UIColor.clearColor().CGColor
        
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
