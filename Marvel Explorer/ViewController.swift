//
//  ViewController.swift
//  Marvel Explorer
//
//  Created by Nathanael Gethers on 6/2/16.
//  Copyright © 2016 dignmg. All rights reserved.
//

import UIKit
import UIImageColors

class ViewController: UIViewController {
    
    @IBOutlet var charNameLabel: UILabel!
    @IBOutlet var charDescLabel: UILabel!
    @IBOutlet var charImage: CharacterUIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

		// Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        MarvelService.sharedInstance.get("characters").query("name", value: "Daredevil").call() {
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
		charDescLabel.text = char.description
        downloadImage(char)
    }
    
    func downloadImage(char: Character){
        print("Download Started")
        char.getDataFromUrl() { (data, response, error)  in
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                guard let data = data where error == nil else { return }
                print(response?.suggestedFilename ?? "")

                self.charImage.image = UIImage(data: data)
                self.charImage.image!.getColors({
                  (colors) in
        //					self.view.backgroundColor = colors.backgroundColor.CGColor

                  let colors = [
                    // colors.primaryColor, colors.secondaryColor, colors.detailColor
                    colors.secondaryColor.CGColor,
                    UIColor.init(red:   3/255, green: 53/255, blue: 70/255, alpha: 1.0).CGColor
                  ]
                    let gradient = RadialGradientLayer(center: CGPointMake(200, 250), radius: 400, colors: colors)
                    gradient.colors = colors
                    gradient.setNeedsDisplay()
                    let newRect = CGRectMake(0, 0, CGRectGetWidth(self.view.frame)
                        , CGRectGetHeight(self.view.frame))
                    gradient.frame = newRect
                    gradient.bounds = newRect
                    self.view.layer.insertSublayer(gradient, atIndex: 0)
                })
            }
        }
    }
    
}

