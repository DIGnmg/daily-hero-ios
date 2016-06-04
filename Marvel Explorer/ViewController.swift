//
//  ViewController.swift
//  Marvel Explorer
//
//  Created by Nathanael Gethers on 6/2/16.
//  Copyright © 2016 dignmg. All rights reserved.
//

import UIKit
import CryptoSwift

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        MarvelService.sharedInstance.initWithKeys("2536b911c2b255811644b1eeec72245a", privateKey: "248baec13b6e23bc9ed5a89c530f707303292c74")
        
//        MarvelService.sharedInstance.get("characters").call()
        MarvelService.sharedInstance.get("characters").query("name", value: "Spider-Man").call()
//        MarvelService.sharedInstance.makeApiCall(url)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

