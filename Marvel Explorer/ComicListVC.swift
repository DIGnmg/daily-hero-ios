//
//  ComicListVC.swift
//  Marvel Explorer
//
//  Created by Nathanael Gethers on 6/28/16.
//  Copyright © 2016 dignmg. All rights reserved.
//

import UIKit

class ComicListVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    fileprivate let comicZoomPresentAnimationController = ComicZoomPresentAnimationController()
    fileprivate let comicZoomDismissAnimationController = ZoomDismissAnimationController()
    
    @IBOutlet var tableView: UITableView!
    
    var comicList = [Comic]()
    let comicListSegueIdentifier = "ComicListSegue"
    var selectedItemRect = CGRect()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.barTintColor = UIColor.init(red:   3/255, green: 53/255, blue: 70/255, alpha: 1.0)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        comicList = MarvelService.sharedInstance.loadedComics
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comicList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let comic = MarvelService.sharedInstance.loadedComics[(indexPath as NSIndexPath).row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ComicCell") as? ComicCell {
            cell.configureCell(comic)
            return cell
        } else {
            return ComicCell()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if comicList.count > 0 {
            self.tableView.backgroundView = nil
            return 1
        } else {
            
            let noDataLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.tableView.bounds.size.width, height: self.tableView.bounds.size.height))
            noDataLabel.text = "No Data Available"
            noDataLabel.textColor = UIColor.black
            noDataLabel.textAlignment = NSTextAlignment.center
            self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
            self.tableView.backgroundView = noDataLabel
        }
        return 0
    }
    
    // MARK: - UITableViewDelegate Methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == comicListSegueIdentifier, let destination = segue.destination as? ComicDetailVC, let comicIndex = (tableView.indexPathForSelectedRow as IndexPath?)?.row {
            selectedItemRect = setSelectedListItemRect()
            destination.comic = comicList[comicIndex]
            destination.transitioningDelegate = self
        }
    }
    
    func setSelectedListItemRect() -> CGRect {
        let selectedRow = tableView.indexPathForSelectedRow
        let rectOfRow = tableView.rectForRow(at: selectedRow!)
        
        return tableView.convert(rectOfRow, to: self.view)
    }

}

extension ComicListVC: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        comicZoomPresentAnimationController.originFrame = selectedItemRect
        return comicZoomPresentAnimationController
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        comicZoomDismissAnimationController.destinationFrame = selectedItemRect
        return comicZoomDismissAnimationController
    }
}
