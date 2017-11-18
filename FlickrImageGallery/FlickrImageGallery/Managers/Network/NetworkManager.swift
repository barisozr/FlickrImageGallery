//
//  NetworkManager.swift
//  FlickrImageGallery
//
//  Created by Barış Özer on 11/18/17.
//  Copyright © 2017 Tigerspike. All rights reserved.
//

import Foundation
import UIKit

typealias flickrItemResponseHandler = ([FlickrItem]?) -> Void
typealias imageResponseHandler = (UIImage?) -> Void

enum Paths:String {
    case publicPhotos = "feeds/photos_public.gne"
}

struct NetworkManager {
    
    private var baseUrl = "https://api.flickr.com/services/"
    private let formatQuery = URLQueryItem(name: "format", value: "json")
    private let jsonQuery = URLQueryItem(name: "nojsoncallback", value: "1")
    
    static let sharedManager = NetworkManager()
    private init() {}
    
    func getPhotos(userId:String? = nil, completion:@escaping flickrItemResponseHandler) {
        let urlComponents = NSURLComponents(string: baseUrl + Paths.publicPhotos.rawValue)
        var items = [formatQuery, jsonQuery]
        if let id = userId, id.isNonEmpty {
            items.append(URLQueryItem(name: "id", value: id))
        }
        urlComponents?.queryItems = items
        if let url = urlComponents?.url {
            let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                if let d = data, let dict = d.toDictionary(), let items = dict["items"] as? [[String:Any]], error == nil, items.count > 0 {
                    var result = [FlickrItem]()
                    for subDict in items {
                        result.append(FlickrItem(subDict))
                    }
                    completion(result)
                }
                else {
                    completion(nil)
                }
            })
            task.resume()
        }
        else {
            completion(nil)
        }
    }
    
    static func downloadImage(url:URL?, completion:@escaping imageResponseHandler) {
        if let u = url {
            let task = URLSession.shared.dataTask(with: u, completionHandler: { (data, response, error) in
                DispatchQueue.main.async {
                    if let d = data, error == nil {
                        completion(UIImage(data: d))
                    }
                    else {
                        completion(nil)
                    }
                }
            })
            task.resume()
        }
        else {
            completion(nil)
        }
    }
}
