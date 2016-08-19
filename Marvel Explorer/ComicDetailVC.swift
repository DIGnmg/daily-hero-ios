//
//  ComicDetailVC.swift
//  Marvel Explorer
//
//  Created by Nathanael Gethers on 7/8/16.
//  Copyright © 2016 dignmg. All rights reserved.
//

import UIKit

class ComicDetailVC: UIViewController {

    @IBOutlet weak var comicName: UILabel!
    
    @IBOutlet weak var comicDesc: UILabel!
    @IBOutlet weak var comicImage: UIImageView!
    
    var comic = Comic()
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        comicName.text = comic.name
        comicDesc.text = comic.description
        comicImage.image = comic.image
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func close(sender: AnyObject) {
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
