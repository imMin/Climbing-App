//
//  AddViewController.swift
//  Climbing App
//
//  Created by Min Hu on 6/12/15.
//  Copyright (c) 2015 Min Hu. All rights reserved.
//

import UIKit

class AddViewController: UIViewController, UIViewControllerTransitioningDelegate {

    @IBOutlet var mainView: UIView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var fiveButton: UIButton!
    @IBOutlet weak var vButton: UIButton!
    
    var startingPoint: CGFloat!
    
    
	required init(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		modalPresentationStyle = UIModalPresentationStyle.Custom
		transitioningDelegate = self
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupMenu()
//        mainView.backgroundColor = UIColor.clearColor()
		self.navigationController?.view.backgroundColor = UIColor.clearColor()
		
		
    }
    
    

    func setupMenu() {
        startingPoint = 650
        fiveButton.center.y = startingPoint
        vButton.center.y = startingPoint
        backgroundView.backgroundColor = UIColor(red:0.0, green:0.0, blue:0.0, alpha:0.1)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewDidAppear(animated: Bool) {
        fiveButton.alpha = 1
        vButton.alpha = 1

        backgroundView.backgroundColor = UIColor(red:0.0, green:0.0, blue:0.0, alpha:0.1)
        
        UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: nil, animations: { () -> Void in
            self.fiveButton.frame.origin.y = 450
            }, completion: nil)
        
        
        UIView.animateWithDuration(0.5, delay: 0.1, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: nil, animations: { () -> Void in
            self.vButton.frame.origin.y = 450
            }, completion: nil)

    }
    
    func transitionOut() {
        
        UIView.animateWithDuration(0.4, animations: { () -> Void in
            self.backgroundView.backgroundColor = UIColor.clearColor()
        })
        
        UIView.animateWithDuration(0.4, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: nil, animations: { () -> Void in
            self.fiveButton.frame.origin.y = 650
            }, completion: nil)
        UIView.animateWithDuration(0.4, delay: 0.1, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: nil, animations: { () -> Void in
            self.vButton.frame.origin.y = 650
            }, completion: nil)
        
    }
    
    
    @IBAction func didTapBackground(sender: UITapGestureRecognizer) {
        println("background tapped!")
        transitionOut()
        delay(0.2) {
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }

}
