//
//  MasterViewController.swift
//  StretchMyHeader
//
//  Created by Kerry Toonen on 2016-02-16.
//  Copyright © 2016 Kerry Toonen. All rights reserved.
//

import UIKit

private let kTableHeaderHeight: CGFloat = 300.0
private let kTableHeaderCutAway: CGFloat = 80.0


class MasterViewController: UITableViewController {
    
    //MARK: Properties
    
var items = [NewsItem]()
var headerView: UIView!
var headerMaskLayer: CAShapeLayer!

    

    var detailViewController: DetailViewController? = nil
    


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()

        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
        self.navigationItem.rightBarButtonItem = addButton
        
    
        
        headerView = tableView.tableHeaderView
        tableView.tableHeaderView = nil
        
        tableView.addSubview(headerView)
        
        tableView.contentInset = UIEdgeInsets(top: kTableHeaderHeight, left: 0, bottom: 0, right: 0)
        tableView.contentOffset = CGPoint(x: 0, y: -kTableHeaderHeight)
        
        updateHeaderView()
        
        headerMaskLayer = CAShapeLayer()
        headerMaskLayer.fillColor = UIColor.blackColor().CGColor
        
        headerView.layer.mask = headerMaskLayer
        
        //adjust the content inset
        
        let effectiveHeight = kTableHeaderHeight-kTableHeaderCutAway/2
        tableView.contentInset = UIEdgeInsets(top: effectiveHeight, left: 0, bottom: 0, right: 0)
        
        tableView.contentOffset=CGPoint(x: 0, y: -effectiveHeight)
        
        
        
        //Add news items
        
        items = [
        
        NewsItem(category:.World, summary: "Climate change protests, divestments meet fossil fuels realities"),
        
        NewsItem(category:.Europe, summary: "Scotland's 'Yes' leader says independence vote is 'once in a lifetime'"),
        
        NewsItem(category:.MiddleEast, summary: "Airstrikes boost Islamic State, FBI director warns more hostages possible"),
        
        NewsItem(category:.Africa, summary: "Nigeria says 70 dead in building collapse; questions S. Africa victim claim"),
        
        NewsItem(category:.AsiaPacific, summary: "Despite UN ruling, Japan seeks backing for whale hunting"),
        
        NewsItem(category:.Americas, summary: "Officials: FBI is tracking 100 Americans who faught alongside IS in Syria"),
        
        NewsItem(category:.World, summary: "South Africa in $40 billion deal for Russian nuclear reactors"),
        
        NewsItem(category:.Europe, summary: "'One million babies' created by EU student exchanges"),
        ]
   
        
       
        
        tableView.estimatedRowHeight = 68.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        prefersStatusBarHidden()
        
        updateHeaderView()
    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        updateHeaderView()
    }
    
    func updateHeaderView() {
        
        var headerRect = CGRect(x: 0, y: -kTableHeaderHeight, width: tableView.bounds.width, height: kTableHeaderHeight)
        
        if tableView.contentOffset.y < -kTableHeaderHeight {
            headerRect.origin.y = tableView.contentOffset.y
            headerRect.size.height = -tableView.contentOffset.y
        }
        
        headerView.frame = headerRect
        
        let path = UIBezierPath()
        
        path.moveToPoint(CGPoint (x: 0, y: 0))
        path.addLineToPoint(CGPoint (x: headerRect.width, y: 0))
        path.addLineToPoint(CGPoint (x: headerRect.width, y: headerRect.height))
        path.addLineToPoint(CGPoint(x: 0, y: headerRect.height-kTableHeaderCutAway))
        headerMaskLayer?.path = path.CGPath
    }
    
    
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

//    func insertNewObject(sender: AnyObject) {
//        objects.insert(NSDate(), atIndex: 0)
//        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
//        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
//    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let item = items[indexPath.row]
                let controller = segue.destinationViewController as! DetailViewController
//                controller.detailItem = item
            }
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! MyCustomCellTableViewCell

        let item = items[indexPath.row]
        cell.newsItem = item
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            items.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }


}

