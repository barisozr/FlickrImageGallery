//
//  Extensions.swift
//  FlickrImageGallery
//
//  Created by Barış Özer on 11/18/17.
//  Copyright © 2017 Tigerspike. All rights reserved.
//

import Foundation

extension String {
    
    var isNonEmpty:Bool {
        return !isEmpty
    }
    
    func toDate() -> Date? {
        return Date.inputFormatter.date(from: self)
    }
    
    func getAuthorName() -> String {
        var trimmed = self
        if let index = trimmed.index(of: "\"") {
            trimmed = String(trimmed[trimmed.index(after: index)...])
        }
        if let index = trimmed.index(of: "\"") {
            trimmed = String(trimmed[..<index])
        }
        return trimmed
    }
}

extension Date {
    
    static var inputFormatter:DateFormatter {
        let frm = DateFormatter()
        frm.dateFormat = "yyyy-MM-dd'T'HH:mm:ssxxxxx"
        return frm
    }
    
    static var outputFormatter:DateFormatter {
        let frm = DateFormatter()
        frm.dateFormat = "yyyy-MM-dd"
        return frm
    }
    
    func toString() -> String {
        return Date.outputFormatter.string(from: self)
    }
}

extension Data {
    
    func toDictionary() -> [String:Any]? {
        do {
            return try JSONSerialization.jsonObject(with: self, options: []) as? [String:Any]
        }
        catch let e {
            print("JSON -> [String:Any] exception \(e.localizedDescription)")
            return nil
        }
    }
}
