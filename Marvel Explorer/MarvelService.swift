//
//  MarvelService.swift
//  Marvel Explorer
//
//  Created by Nathanael Gethers on 6/3/16.
//  Copyright © 2016 dignmg. All rights reserved.
//

import Foundation
import UIKit

class MarvelService {
    
    static let sharedInstance = MarvelService()
    
    fileprivate var _character = Character()
    
    fileprivate var _loadedComics = [Comic]()
    
    var loadedComics: [Comic] {
        return _loadedComics
    }
    
    var loadedCharacter: Character {
        return _character
    }
    
    func getChar() -> Character {
        return self._character
    }
    
    func getDailyHero(_ callback: @escaping (Character) -> Void) -> Void {
        self.getHero() { (char: Character) in
            callback(self._character)
            self.getComics() { (comics: [Comic]) in
                if comics.count > 0 {
                    self._character.addComics(comics)
                }
            }
        }
    }
    
    func getComics(_ callback: @escaping (([Comic]) -> Void)) -> Void {
        let urlString = "http://localhost:5000/daily-comics"
        self.makeCall(urlString) { (data, response, error)  in
            if let dataContent = data {
                do {
                    
                    let json = try JSONSerialization.jsonObject(with: dataContent, options: JSONSerialization.ReadingOptions.allowFragments)
                    
                    if let data = json as? Dictionary<String, AnyObject> {
                        if let list = data["data"] as? [Dictionary<String, AnyObject>] {
                            for item in list {
                                if let id = item["id"] as? Int, let prices = item["prices"] as? [Dictionary<String, AnyObject>], let name = item["title"] as? String, let description = item["description"] as? String, let resourceURI = item["resourceURI"] as? String, let thumbnail = item["thumbnail"] as? Dictionary<String, String> {
                                    
                                    let comic = Comic(prices: prices, id: id, name: name, description: description, resourceURI: resourceURI, thumbnail: thumbnail)
                                    
                                    comic.getDataFromUrl({ (data, response, error) in
                                        self._loadedComics.append(comic)
                                    })
                                    
                                    DispatchQueue.main.async(execute: {
                                        callback(self._loadedComics)
                                    })
                                }
                            }
                        }
                    } else {
                        print("no data")
                    }
                    
                } catch {
                    print("Boom You Failed")
                }
            }
        }
    }
    
    func getHero(_ callback: @escaping ((Character) -> Void )) -> Void {
        let urlString = "http://localhost:5000/daily"
        self.makeCall(urlString) { (data, response, error)  in
            if let dataContent = data {
                do {

                    let json = try JSONSerialization.jsonObject(with: dataContent, options: JSONSerialization.ReadingOptions.allowFragments) as! Dictionary<String, AnyObject>
                    
                    if let apiData = json["data"] {
                        var charModel: Character = Character()
                        if let item = apiData[0] as? [String:Any] {
                            if let id = item["id"] as? Int, let name = item["name"] as? String, let description = item["description"] as? String, let resourceURI = item["resourceURI"] as? String, let thumbnail = item["thumbnail"] as? Dictionary<String, String> {

                                charModel = Character(id: id, name: name, description: description, resourceURI: resourceURI, thumbnail: thumbnail)
                            }
                        }
                        self._character = charModel
                        
                        DispatchQueue.main.async(execute: {
                            callback(self._character)
                        })
                    }
                    
                } catch {
                    print("Boom You Failed")
                }
            }
        }
    }
    
    func makeCall(_ url: String, callback: @escaping (_ data: Data?, _ response: URLResponse?, _ error: NSError? ) -> Void) {
        let url = URL(string: url)
        let request = URLRequest(url: url!)
        
        let session = URLSession.shared.dataTask(with: request) { (data, response, error) in
            callback(data, response, error as NSError?)
            return
        }
        session.resume()
    }
    
//    internal func makeCall(url: String, callback: ((AnyObject) -> Void)) -> Void {
//        let url = NSURL(string: url)
//        
//        let session = NSURLSession.sharedSession()
//        session.dataTaskWithURL(url!) { (data: NSData?, response: NSURLResponse?, error: NSError?) in
//            if let dataContent = data {
//                do {
//                    
//                    let json = try NSJSONSerialization.JSONObjectWithData(dataContent, options: NSJSONReadingOptions.AllowFragments)
//                    
//                    if let data = json as? Dictionary<String, AnyObject> {
//                        let apiData = data["data"]
//                        var charModel: Character = Character()
//                        if let item = apiData![0] {
//                            if let id = item["id"] as? Int, let name = item["name"] as? String, let description = item["description"] as? String, let resourceURI = item["resourceURI"] as? String, let thumbnail = item["thumbnail"] as? Dictionary<String, String> {
//                                
//                                charModel = Character(id: id, name: name, description: description, resourceURI: resourceURI, thumbnail: thumbnail)
//                            }
//                        }
//                        dispatch_async(dispatch_get_main_queue(), {
//                            callback(charModel)
//                        })
//                    }
//                    
//                } catch {
//                    print("Boom You Failed")
//                }
//            }
//        }.resume()
//    }
}
