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
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
		
		
		
        
        MarvelService.sharedInstance.get("characters").query("name", value: "Hulk").call() {
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

					let locations = [0.0, 1.0];
					let gradient: CAGradientLayer = CAGradientLayer()
					gradient.colors = colors
					gradient.locations = locations
					gradient.startPoint = CGPoint(x: 1.0, y: 0.0)
					gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
					gradient.frame = CGRect(x: 0.0, y: 0.0, width: self.view.frame.size.width, height: self.view.frame.size.height)

					//let gradient = RadialGradientLayer(center: CGPointMake(50.0, 50.0), radius: 200, colors: colors)
					//gradient.colors = colors
					//gradient.setNeedsDisplay()
					self.view.layer.insertSublayer(gradient, atIndex: 0)
				})
            }
        }
    }
    
}

