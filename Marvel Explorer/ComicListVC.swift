//
//  ComicListVC.swift
//  Marvel Explorer
//
//  Created by Nathanael Gethers on 6/28/16.
//  Copyright © 2016 dignmg. All rights reserved.
//

import UIKit

class ComicListVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    
    var comicList = [Comic]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        comicList = MarvelService.sharedInstance.loadedComics
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comicList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let comic = MarvelService.sharedInstance.loadedComics[indexPath.row]
        
        if let cell = tableView.dequeueReusableCellWithIdentifier("ComicCell") as? ComicCell {
            cell.configureCell(comic)
            return cell
        } else {
            return ComicCell()
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if comicList.count > 0 {
            self.tableView.backgroundView = nil
            return 1
        } else {
            
            let noDataLabel: UILabel = UILabel(frame: CGRectMake(0, 0, self.tableView.bounds.size.width, self.tableView.bounds.size.height))
            noDataLabel.text = "No Data Available"
            noDataLabel.textColor = UIColor.blackColor()
            noDataLabel.textAlignment = NSTextAlignment.Center
            self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
            self.tableView.backgroundView = noDataLabel
        }
        return 0
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
