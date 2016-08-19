//
//  ComicListVC.swift
//  Marvel Explorer
//
//  Created by Nathanael Gethers on 6/28/16.
//  Copyright © 2016 dignmg. All rights reserved.
//

import UIKit

class ComicListVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private let comicZoomPresentAnimationController = ComicZoomPresentAnimationController()
    private let comicZoomDismissAnimationController = ZoomDismissAnimationController()
    
    @IBOutlet var tableView: UITableView!
    
    var comicList = [Comic]()
    let comicListSegueIdentifier = "ComicListSegue"
    var selectedItemRect = CGRect()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.hidden = false
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        comicList = MarvelService.sharedInstance.loadedComics
        tableView.reloadData()
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
    
    // MARK: - UITableViewDelegate Methods
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    // MARK: - Animate Table View Cell
    
//    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
//        cell.alpha = 0
//        let rorationTransform = CATransform3DTranslate(CATransform3DIdentity, -500, 10, 0)
//        cell.layer.transform = rorationTransform
//        
//        UIView.animateWithDuration(0.4) {
//            cell.alpha = 1
//            cell.layer.transform = CATransform3DIdentity
//        }
//    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == comicListSegueIdentifier, let destination = segue.destinationViewController as? ComicDetailVC, comicIndex = tableView.indexPathForSelectedRow?.row {
            selectedItemRect = setSelectedListItemRect()
            destination.comic = comicList[comicIndex]
            destination.transitioningDelegate = self
        }
    }
    
    func setSelectedListItemRect() -> CGRect {
        let selectedRow = tableView.indexPathForSelectedRow
        let rectOfRow = tableView.rectForRowAtIndexPath(selectedRow!)
        
        return tableView.convertRect(rectOfRow, toView: self.view)
    }

}

extension ComicListVC: UIViewControllerTransitioningDelegate {
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        comicZoomPresentAnimationController.originFrame = selectedItemRect
        return comicZoomPresentAnimationController
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        comicZoomDismissAnimationController.destinationFrame = selectedItemRect
        return comicZoomDismissAnimationController
    }
}
