//
//  Character.swift
//  Marvel Explorer
//
//  Created by Nathanael Gethers on 6/4/16.
//  Copyright © 2016 dignmg. All rights reserved.
//

import Foundation

class Character: DailyHero {
    
    fileprivate var _comics: [Comic] = [Comic]()
    
    var comics: [Comic] {
        get {
            return _comics
        }
    }
    
    override init(id: Int?, name: String?, description: String?, resourceURI: String?, thumbnail: Dictionary<String, String>?) {
        super.init(id: id, name: name, description: description, resourceURI: resourceURI, thumbnail: thumbnail)
    }
    
    convenience init(){
        self.init(id: nil, name: nil, description: nil, resourceURI: nil, thumbnail: nil)
    }
    
    func addComics(_ comics: [Comic]) -> Void {
        self._comics = comics
    }
    
}
