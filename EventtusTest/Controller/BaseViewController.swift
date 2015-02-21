//
//  ViewController.swift
//  SFSwiftNotification
//
//  Created by Simone Ferrini on 13/07/14.
//  Copyright (c) 2014 sferrini. All rights reserved.
//

import UIKit

class BaseViewController: UITableViewController, SFSwiftNotificationProtocol {
    
    var notifyFrame:CGRect?
    var notifyView:SFSwiftNotification?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reachabilityChanged:", name: ReachabilityChangedNotification, object: nil)

        
        
        notifyFrame = CGRectMake(0, 0, CGRectGetMaxX(self.view.frame), 50)
        notifyView = SFSwiftNotification(frame: notifyFrame!,
            title: nil,
            animationType: AnimationType.AnimationTypeCollision,
            direction: Direction.LeftToRight,
            delegate: self)
        notifyView!.backgroundColor = UIColor.orangeColor()
        notifyView!.label.textColor = UIColor.whiteColor()
        self.view.addSubview(notifyView!)
    }

    
    func didNotifyFinishedAnimation(results: Bool) {
        
        println("SFSwiftNotification finished animation")
    }
    
    func didTapNotification() {
        
        let tapAlert = UIAlertController(title: "SFSwiftNotification",
            message: "You just tapped the notificatoion",
            preferredStyle: UIAlertControllerStyle.Alert)
        tapAlert.addAction(UIAlertAction(title: "OK", style: .Destructive, handler: nil))
        self.presentViewController(tapAlert, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func reachabilityChanged(note: NSNotification) {
        let reachability = note.object as Reachability
        
        if reachability.isReachable() {
            notifyView!.label.text = reachability.currentReachabilityString

            self.notifyView!.animate(notifyFrame!, delay: 1)

        } else {
            println("Not Interner")
            notifyView!.label.text = reachability.currentReachabilityString

            self.notifyView!.animate(notifyFrame!, delay: 1)

        
        }
    }
}

