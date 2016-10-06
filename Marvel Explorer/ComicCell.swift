//
//  ComicCell.swift
//  Marvel Explorer
//
//  Created by Nathanael Gethers on 6/28/16.
//  Copyright © 2016 dignmg. All rights reserved.
//

import UIKit

class ComicCell: UITableViewCell {

    @IBOutlet weak var comicImg: UIImageView!
    @IBOutlet weak var comicTitleLabel: UILabel!
//    @IBOutlet weak var comicdescLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configureCell(_ comic: Comic) -> Void {
        comicImg.image = comic.image
        comicTitleLabel.text = comic.name
//        comicdescLabel.text = post.postDescription
    }
    
}
