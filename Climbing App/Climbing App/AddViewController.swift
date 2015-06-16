//
//  AddViewController.swift
//  Climbing App
//
//  Created by Min Hu on 6/12/15.
//  Copyright (c) 2015 Min Hu. All rights reserved.
//

import UIKit

class AddViewController: UIViewController, UIViewControllerTransitioningDelegate {

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
        startingPoint = 650
        fiveButton.center.y = startingPoint
        vButton.center.y = startingPoint
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    override func viewDidAppear(animated: Bool) {
        fiveButton.alpha = 1
        vButton.alpha = 1
        
        UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: nil, animations: { () -> Void in
            self.fiveButton.frame.origin.y = 450
            }, completion: nil)
        
        
        UIView.animateWithDuration(0.5, delay: 0.1, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: nil, animations: { () -> Void in
            self.vButton.frame.origin.y = 450
            }, completion: nil)

    }
    
    func transitionOut() {
        UIView.animateWithDuration(0.4, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: nil, animations: { () -> Void in
            self.fiveButton.frame.origin.y = 650
            }, completion: nil)
        UIView.animateWithDuration(0.4, delay: 0.1, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: nil, animations: { () -> Void in
            self.vButton.frame.origin.y = 650
            }, completion: nil)
        
    }
    
    
    @IBAction func didTapBackground(sender: UITapGestureRecognizer) {
        transitionOut()
        delay(0.2) {
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
}
