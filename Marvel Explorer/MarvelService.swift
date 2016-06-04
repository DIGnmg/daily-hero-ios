//
//  MarvelService.swift
//  Marvel Explorer
//
//  Created by Nathanael Gethers on 6/3/16.
//  Copyright © 2016 dignmg. All rights reserved.
//

import Foundation

class MarvelService {
    static let sharedInstance = MarvelService()
    
    private var _privateKey: String?
    private var _publicKey: String?
    private var _currentScope: String?
    private var _queryArray = [Dictionary<String, AnyObject>]()
    
    var publicKey: String? {
        get {
            return _publicKey
        }
        set(newKey) {
            _publicKey = newKey
        }
    }
    
    var privateKey: String? {
        get {
            return _privateKey
        }
        set(newKey) {
            _privateKey = newKey
        }
    }
    
    internal func initWithKeys(publicKey: String?, privateKey: String?) -> Void {
        self._publicKey = publicKey
        self._privateKey = privateKey
    }
    
    internal func get(scope: String) -> MarvelService {
        self._currentScope = scope
        return self
    }
    
    internal func call() -> Void {
        let url = createMarvelApiUrlString()
        makeApiCall(url)
    }
    
    internal func query(key: String, value: String) -> MarvelService {
        var queryDict = Dictionary<String, AnyObject>()
        queryDict[key] = value
        self._queryArray.append(queryDict)
        return self
    }
    
    internal func makeQueryString() -> String {
        var currentQueryString = ""
        for query in _queryArray {
            var tempQ = ""
//            "name=Spider-Man&limit=10"
            for key in query.keys {
                print(key)
                tempQ = "\(key)=\(query[key]!)"
                currentQueryString += tempQ
            }
        }
        return currentQueryString
    }
    
    internal func createHash(ts: String) -> String {
        
        let stringToHash = ts + self._privateKey! + self._publicKey!
        
        let hash = stringToHash.md5()
        return hash
    }
    
    internal func createMarvelApiUrlString() -> String {
        // Create TimeStamp
        let timestamp = round(NSDate().timeIntervalSince1970*1000).hashValue
        // Create Hash
        let hash = createHash(String(timestamp))
        // Scope
        let scope = _currentScope
        // Query
        let query = makeQueryString()
        
        let marvelAPiString = "http://gateway.marvel.com/v1/public/\(scope!)?\(query)&ts=\(timestamp)&apikey=\(self._publicKey)a&hash=\(hash)"
        return marvelAPiString
    }
    
    internal func makeApiCall(url: String?) -> Void {
        let newUrl: NSURL
        let session = NSURLSession.sharedSession()
        
        if let url = url {
            
            newUrl = NSURL(string: url)!
            
            let task = session.dataTaskWithURL(newUrl) { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
                if let urlConent = data {
                    do {
                        
                        let json = try NSJSONSerialization.JSONObjectWithData(urlConent, options: NSJSONReadingOptions.AllowFragments)
                        
                        if let data = json["data"] as? Dictionary<String, AnyObject> {
                            print(data["results"])
                        }
                        
                    } catch {
                        print("There was an error")
                    }
                }
            }
            
            task.resume()
        }
    }
    
}