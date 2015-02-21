//
//  EventModel.swift
//  EventtusTest
//
//  Created by binaryboy on 2/16/15.
//  Copyright (c) 2015 AhmedHamdy. All rights reserved.
//

import UIKit
private let EventSharedInstance = EventModel()
var events: Array<Event> = Array<Event>()

class EventModel: NSObject {
   

    class var sharedInstance: EventModel {
        return EventSharedInstance
    }
    func setObject(dicsArray: Array<NSDictionary>){
        for dic: NSDictionary in dicsArray
        {
            var eventObject:Event=Event( dic:dic );
            events.append(eventObject)
            
        }
    }
    
    
    func getObjects()->Array<Event>{
        //println(events[0].name)

        return events;
    }
}
