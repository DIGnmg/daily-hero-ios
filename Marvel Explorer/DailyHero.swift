//
//  DailyHero.swift
//  Marvel Explorer
//
//  Created by Nathanael Gethers on 6/29/16.
//  Copyright © 2016 dignmg. All rights reserved.
//

import Foundation
import UIKit

class DailyHero {
    
    // id (int, optional): The unique ID of the character resource.
    private var _id: Int?
    // name (string, optional): The name of the character.
    private var _name: String?
    // description (string, optional): A short bio or description of the character.
    private var _description: String?
    // resourceURI (string, optional): The canonical URL identifier for this resource.
    private var _resourceURI: String?
    // thumbnail (Image, optional): The representative image for this character.
    private var _thumbnail: Dictionary<String, String>?
    
    // thumbnail (Image, optional): The representative image for this character.
    private var _image: UIImage?
    
    var id: Int? {
        return self._id
    }
    
    var name: String? {
        return self._name
    }
    
    var description: String? {
        return self._description
    }
    
    var resourceURI: String? {
        return self._resourceURI
    }
    
    var thumbnail: Dictionary<String, String>? {
        return self._thumbnail
    }
    
    var image: UIImage? {
        return self._image
    }

    init(id: Int?, name: String?, description: String?, resourceURI: String?, thumbnail: Dictionary<String, String>?){
        self._description = description
        self._id = id
        self._name = name
        self._resourceURI = resourceURI
        self._thumbnail = thumbnail
    }
    
    func getDataFromUrl(completion: ((data: NSData?, response: NSURLResponse?, error: NSError? ) -> Void)) {
        let urlPath = "\(self._thumbnail!["path"]!).\(self._thumbnail!["extension"]!)"
        let url = NSURL(string: urlPath)
        NSURLSession.sharedSession().dataTaskWithURL(url!) { (data, response, error) in
            if let imageData = data {
                self._image = UIImage(data: imageData)
            }
            completion(data: data, response: response, error: error)
            }.resume()
    }
    
}