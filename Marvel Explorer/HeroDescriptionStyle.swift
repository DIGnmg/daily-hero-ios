//
//  HeroDescriptionStyle.swift
//  Marvel Explorer
//
//  Created by Nathanael Gethers on 6/6/16.
//  Copyright © 2016 dignmg. All rights reserved.
//

import UIKit

class HeroDescriptionStyle: UILabel {
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func updateText(_ text: String) -> Void {
        // Create New Style
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 8
        style.alignment = NSTextAlignment.justified
        
        //
        let attributes = [
            NSParagraphStyleAttributeName : style,
            NSBaselineOffsetAttributeName : NSNumber(value: 0 as Float)
        ]
        self.attributedText = NSAttributedString(string: text, attributes:attributes)
    }

}
