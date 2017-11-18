//
//  FlickrItem.swift
//  FlickrImageGallery
//
//  Created by Barış Özer on 11/18/17.
//  Copyright © 2017 Tigerspike. All rights reserved.
//

import Foundation

struct FlickrItem {
    
    var title:String?
    var link:URL?
    var media:URL?
    var takenDate:Date?
    var publishedDate:Date?
    var author:String?
    var authorId:String?
    var tags:[String]?
    
    init(_ dict:[String:Any]) {
        title = dict["title"] as? String
        if let u = dict["link"] as? String {
            link = URL(string: u)
        }
        if let json = dict["media"] as? [String:Any], let m = json["m"] as? String {
            media = URL(string: m)
        }
        if let d = dict["date_taken"] as? String {
            takenDate = d.toDate()
        }
        if let d = dict["published"] as? String {
            publishedDate = d.toDate()
        }
        if let a = dict["author"] as? String {
            author = a.getAuthorName()
        }
        authorId = dict["author_id"] as? String
        if let list = (dict["tags"] as? String)?.components(separatedBy: " "), list.count > 0 {
            tags = []
            tags?.append(contentsOf: list)
        }
    }
}
