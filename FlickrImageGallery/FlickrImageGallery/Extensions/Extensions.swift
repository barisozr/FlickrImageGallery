//
//  Extensions.swift
//  FlickrImageGallery
//
//  Created by Barış Özer on 11/18/17.
//  Copyright © 2017 Tigerspike. All rights reserved.
//

import Foundation

extension String {
    
    private static var formatter:DateFormatter {
        let frm = DateFormatter()
        frm.dateFormat = "yyyy-MM-dd'T'HH:mm:ssxxxxx"
        return frm
    }
    
    func toDate() -> Date? {
        return String.formatter.date(from: self)
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
