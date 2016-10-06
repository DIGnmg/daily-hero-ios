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
        self.navigationController?.navigationBar.barTintColor = UIColor.init(red:   3/255, green: 53/255, blue: 70/255, alpha: 1.0)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
        MarvelService.sharedInstance.getDailyHero({ (char: Character) in
            if (char.id != nil) {
                self.printName(char)
            }
        })
        
    }
    
    func printName(_ char: Character) -> Void {
        charNameLabel.text = char.name?.uppercased()
        charDescLabel.updateText(char.description!)
        downloadImage(char)
    }
    
    func downloadImage(_ char: Character){
        print("Download Started")
        char.getDataFromUrl() { (data, response, error)  in
            DispatchQueue.main.async { () -> Void in
                guard let data = data , error == nil else { return }
                
                self.charImage.image = UIImage(data: data)
                self.charImage.image!.getColors { colors in
                    self.charImage.createColorBorder(colors.primaryColor)
                    let colors = [
                        colors.secondaryColor.cgColor,
                        UIColor.init(red:   3/255, green: 53/255, blue: 70/255, alpha: 1.0).cgColor
                    ]
                    let gradient = RadialGradientLayer(center: CGPoint(x: 200, y: 250), radius: 450, colors: colors)
                    gradient.colors = colors
                    gradient.setNeedsDisplay()
                    gradient.frame = self.view.frame
                    gradient.bounds = self.view.bounds
                    self.view.layer.insertSublayer(gradient, at: 0)
                }
            }
        }
    }
    
}

