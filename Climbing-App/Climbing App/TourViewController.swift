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
    @IBOutlet weak var videoView: UIView!
	
	var playerLayer: AVPlayerLayer!
	
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
//        var filePath = NSBundle.mainBundle().pathForResource("alexclimber", ofType: "gif")
//        var gif = NSData(contentsOfFile: filePath!)
//		
//        var webViewBG = UIWebView(frame: self.view.frame)
//        webViewBG.loadData(gif, MIMEType: "image/gif", textEncodingName: nil, baseURL: nil)
//        webViewBG.userInteractionEnabled = false;
//        videoView.addSubview(webViewBG)
		
		
		var filePath = NSBundle.mainBundle().pathForResource("alex", ofType: "mp4")
		var mp4 = NSURL(fileURLWithPath: filePath!)
		playerLayer = AVPlayerLayer(player: AVPlayer(URL: mp4))
		playerLayer.frame = CGRectMake(0, 0, videoView.frame.size.width, videoView.frame.size.height)
		videoView.layer.addSublayer(playerLayer)
		playerLayer.player.play()
		
		NSNotificationCenter.defaultCenter().addObserver(self, selector: "playVideo:", name: AVPlayerItemDidPlayToEndTimeNotification, object: nil)
		
		
        var filter = UIView()
        filter.frame = self.view.frame
        filter.backgroundColor = UIColor.blackColor()
        filter.alpha = 0.05
        videoView.addSubview(filter)
        
        scrollView.contentSize = CGSize(width: 1600, height: 386)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	
	func playVideo(notification: NSNotification) {
		let playerItem = notification.object as! AVPlayerItem
		playerItem.seekToTime(kCMTimeZero)
		playerLayer.player.play()
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
