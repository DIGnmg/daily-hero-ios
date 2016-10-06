//
//  Comic.swift
//  Marvel Explorer
//
//  Created by Nathanael Gethers on 6/28/16.
//  Copyright © 2016 dignmg. All rights reserved.
//

import Foundation

class Comic: DailyHero  {
    
    fileprivate var _prices: [Dictionary<String, AnyObject>]?
    
    var prices: [Dictionary<String, AnyObject>]? {
        get {
            return _prices
        }
    }
    
    init(prices: [Dictionary<String, AnyObject>]?, id: Int?, name: String?, description: String?, resourceURI: String?, thumbnail: Dictionary<String, String>?) {
        super.init(id: id, name: name, description: description, resourceURI: resourceURI, thumbnail: thumbnail)
        self._prices = prices
    }
    
    convenience init(){
        self.init(prices: nil, id: nil, name: nil, description: nil, resourceURI: nil, thumbnail: nil)
    }
    
}
