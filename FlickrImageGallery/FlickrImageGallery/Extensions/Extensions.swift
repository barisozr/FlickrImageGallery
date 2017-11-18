//
//  Extensions.swift
//  FlickrImageGallery
//
//  Created by Barış Özer on 11/18/17.
//  Copyright © 2017 Tigerspike. All rights reserved.
//

import Foundation

extension String {
    
    func toDate() -> Date? {
        return Date.inputFormatter.date(from: self)
    }
    
    func getAuthorName() -> String {
        var trimmed = self.replacingOccurrences(of: "nobody@flickr.com ", with: "")
        if trimmed.count > 1 {
            trimmed.remove(at: trimmed.startIndex)
            trimmed.remove(at: trimmed.endIndex)
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
