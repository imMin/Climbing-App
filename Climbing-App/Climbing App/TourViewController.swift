//
//  TourViewController.swift
//  Climbing App
//
//  Created by Cece Yu on 6/22/15.
//  Copyright (c) 2015 Min Hu. All rights reserved.
//

import UIKit

class TourViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        scrollView.contentSize = CGSize(width: 1600, height: 386)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - UIScrollViewDelegate methods
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        let pageWidth = scrollView.frame.size.width;
        let fractionalPage = scrollView.contentOffset.x / pageWidth;
        let currentPage = Int(round(fractionalPage));
 
        pageControl.currentPage = currentPage
        
    }

}
