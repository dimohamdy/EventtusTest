//
//  TableViewController.swift
//  EventtusTest
//
//  Created by binaryboy on 2/16/15.
//  Copyright (c) 2015 AhmedHamdy. All rights reserved.
//

import UIKit


class TableViewController: BaseViewController {
    var events: Array<Event> = Array<Event>()
    //call Network Manager
    var networkManger: NetworkManger?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate=nil
        self.tableView.dataSource=nil
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reachabilityChanged:", name: ReachabilityChangedNotification, object: nil)
        networkManger  = NetworkManger()


        //getDate();

        
    }
    override func viewWillAppear(animated: Bool) {
        //self.tableView.hidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return events.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("EventCell", forIndexPath: indexPath) as EventCell

        // Configure the cell...
        cell.name.text = events[indexPath.item].name;
        cell.startDate.text=convertDate(events[indexPath.item].startDate);

        let coverImageTask = NSURLSession.sharedSession().dataTaskWithURL(NSURL(string:events[indexPath.item].coverImage)!) {(data, response, error) in
            
            dispatch_async(dispatch_get_main_queue(),{
                cell.coverImage.image = UIImage(data:data)
            });
            
        }
        
        coverImageTask.resume()
        
        
        
        let eventImageTask = NSURLSession.sharedSession().dataTaskWithURL(NSURL(string:events[indexPath.item].image)!) {(data, response, error) in
            
            dispatch_async(dispatch_get_main_queue(),{
                cell.eventImage.image = UIImage(data:data)
            });
            
        }
        
        eventImageTask.resume()

        
        
        
        


        return cell
    }

    func convertDate(date: NSDate)->NSString{
        //
        var dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        
        dateFormatter.dateFormat = "dd-MMM-YYYY"

        
        return dateFormatter.stringFromDate(date)
    }




func getDate(){

    var hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)

    let url = NSURL(string: "http://private-0f744-mohamedfouad.apiary-mock.com/events")
    
    let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in

        self.events =  self.parseJSON(data)
        
        self.tableView.delegate=self
        self.tableView.dataSource=self
        dispatch_async(dispatch_get_main_queue(),{
            self.tableView.reloadData()
            self.tableView.hidden = false
            MBProgressHUD.hideAllHUDsForView(self.view, animated: true) // Or just call hud.hide(true)

            
        });

    }

    task.resume()
    
    
}

func parseJSON(inputData: NSData) -> Array<Event>{

    var error: NSError?


    var eventsDictionary: NSDictionary = NSJSONSerialization.JSONObjectWithData(inputData, options: NSJSONReadingOptions.MutableContainers, error: &error) as NSDictionary
   
        //What A disaster above

    EventModel.sharedInstance.setObject(eventsDictionary.valueForKey("data")?.valueForKey("events") as Array<NSDictionary>);
    
    return EventModel.sharedInstance.getObjects()
}
    
    override func reachabilityChanged(note: NSNotification) {

        let reachability = note.object as Reachability

        if reachability.isReachable() {
            if(events.count == 0){
                getDate();
            }
            
        }else{
            super.reachabilityChanged(note)
        }
    }


}