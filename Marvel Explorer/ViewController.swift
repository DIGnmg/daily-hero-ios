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
    @IBOutlet var charDescLabel: HeroDescriptionStyle!
    @IBOutlet var charImage: CharacterUIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

		// Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        MarvelService.sharedInstance.getDailyHero({ (char: Character) in
            if (char.id != nil) {
                self.printName(char)
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func printName(char: Character) -> Void {
        charNameLabel.text = char.name?.uppercaseString
        charDescLabel.updateText(char.description!)
        downloadImage(char)
    }
    
    func downloadImage(char: Character){
        print("Download Started")
        char.getDataFromUrl() { (data, response, error)  in
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                guard let data = data where error == nil else { return }
                
                self.charImage.image = UIImage(data: data)
                self.charImage.image!.getColors({
                  (colors) in
    
                    self.charImage.createColorBorder(colors.primaryColor)
                    let colors = [
                        colors.secondaryColor.CGColor,
                        UIColor.init(red:   3/255, green: 53/255, blue: 70/255, alpha: 1.0).CGColor
                    ]
                    let gradient = RadialGradientLayer(center: CGPointMake(200, 250), radius: 450, colors: colors)
                    gradient.colors = colors
                    gradient.setNeedsDisplay()
                    gradient.frame = self.view.frame
                    gradient.bounds = self.view.bounds
                    self.view.layer.insertSublayer(gradient, atIndex: 0)
                })
            }
        }
    }
    
}

