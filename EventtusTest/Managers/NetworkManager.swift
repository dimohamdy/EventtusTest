//
//  NetworkManager.swift
//  Reachability Sample
//
//  Created by binaryboy on 2/21/15.
//  Copyright (c) 2015 Joylord Systems. All rights reserved.
//

import Foundation
let useClosures = false
class NetworkManger: NSObject{

    
    let reachability = Reachability.reachabilityForInternetConnection()

      override init() {
        super.init()
        if (useClosures) {
            reachability.whenReachable = { reachability in
                self.updateLabelColourWhenReachable(reachability)
            }
            reachability.whenUnreachable = { reachability in
                self.updateLabelColourWhenNotReachable(reachability)
            }
        } else {
           NSNotificationCenter.defaultCenter().addObserver(self, selector: "reachabilityChanged:", name: ReachabilityChangedNotification, object: reachability)
        }
        
        reachability.startNotifier()
        
        // Initial reachability check
        if reachability.isReachable() {
            //updateLabelColourWhenReachable(reachability)
            // Posting notification from another object
            NSNotificationCenter.defaultCenter().postNotificationName(ReachabilityChangedNotification, object: reachability, userInfo:nil)

            
        } else {
            //updateLabelColourWhenNotReachable(reachability)
            // Posting notification from another object
            NSNotificationCenter.defaultCenter().postNotificationName(ReachabilityChangedNotification, object: reachability, userInfo: nil)
        }
        
    }
    
    deinit {
        
        reachability.stopNotifier()
        
        if (!useClosures) {
            NSNotificationCenter.defaultCenter().removeObserver(self, name: ReachabilityChangedNotification, object: nil)
        }
    }
    
    func updateLabelColourWhenReachable(reachability: Reachability) {
        if reachability.isReachableViaWiFi() {
           // self.networkStatus.textColor = UIColor.greenColor()
        } else {
            //self.networkStatus.textColor = UIColor.blueColor()
        }
        
       // self.networkStatus.text = reachability.currentReachabilityString
    }
    
    func updateLabelColourWhenNotReachable(reachability: Reachability) {
       // self.networkStatus.textColor = UIColor.redColor()
        
        //self.networkStatus.text = reachability.currentReachabilityString
    }
    
    
    func reachabilityChanged(note: NSNotification) {
        let reachability = note.object as Reachability
        
        if reachability.isReachable() {
            updateLabelColourWhenReachable(reachability)
        } else {
            updateLabelColourWhenNotReachable(reachability)
        }
    }
}


