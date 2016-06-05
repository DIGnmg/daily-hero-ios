//
//  ViewController.swift
//  Marvel Explorer
//
//  Created by Nathanael Gethers on 6/2/16.
//  Copyright © 2016 dignmg. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var charNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        MarvelService.sharedInstance.get("characters").query("name", value: "Spider-Man").call() {
            (char: [Character]) in
            self.printName(char[0])
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func printName(char: Character) -> Void {
        charNameLabel.text = char.name
        downloadImage(char)
    }
    
    func downloadImage(char: Character){
        print("Download Started")
        char.getDataFromUrl() { (data, response, error)  in
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                guard let data = data where error == nil else { return }
                print(response?.suggestedFilename ?? "")
                print("Download Finished")
                self.charImage.image = UIImage(data: data)
            }
        }
    }
    
}

