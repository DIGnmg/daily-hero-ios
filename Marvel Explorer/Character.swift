//
//  Character.swift
//  Marvel Explorer
//
//  Created by Nathanael Gethers on 6/4/16.
//  Copyright © 2016 dignmg. All rights reserved.
//

import Foundation

class Character {
    
    //    id (int, optional): The unique ID of the character resource.
    private var _id: Int?
    //    name (string, optional): The name of the character.
    private var _name: String?
    //    description (string, optional): A short bio or description of the character.
    private var _description: String?
    //    modified (Date, optional): The date the resource was most recently modified.
//    private var _modified: NSDate?
    //    resourceURI (string, optional): The canonical URL identifier for this resource.
    private var _resourceURI: String?
    //    urls (Array[Url], optional): A set of public web site URLs for the resource.
//    private var _urls: [String]?
    //    thumbnail (Image, optional): The representative image for this character.
//    private var thumbnail: 
    //    comics (ComicList, optional): A resource list containing comics which feature this character.
//    private var comics: String?
    //    stories (StoryList, optional): A resource list of stories in which this character appears.
//    private var stories: String?
    //    events (EventList, optional): A resource list of events in which this character appears.
//    private var events: String?
    //    series (SeriesList, optional): A resource list of series in which this character appears.
//    private var series: String?
    
    
    var name: String? {
        return self._name
    }
    
    init(id: Int?, name: String?, description: String?, resourceURI: String?){
        self._id = id
        self._name = name
        self._description = description
        self._resourceURI = resourceURI
    }
    
}