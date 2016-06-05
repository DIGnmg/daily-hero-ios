//
//  CharacterUIImageView.swift
//  Marvel Explorer
//
//  Created by Adam Reeves on 6/4/16.
//  Copyright © 2016 dignmg. All rights reserved.
//

import UIKit

class CharacterUIImageView: UIImageView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = self.frame.size.height / 2
        self.clipsToBounds = true
    }
    
}
