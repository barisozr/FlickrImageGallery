//
//  ExtensionsTests.swift
//  FlickrImageGalleryTests
//
//  Created by Barış Özer on 11/18/17.
//  Copyright © 2017 Tigerspike. All rights reserved.
//

import XCTest
@testable import FlickrImageGallery

class ExtensionsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    //MARK: String Extension Tests
    
    func testIsNonEmptyFalse() {
        XCTAssertFalse("".isNonEmpty)
    }
    
    func testIsNonEmptyTrue() {
        XCTAssertTrue("Tigerspike".isNonEmpty)
    }
    
    func testIsNonEmptyCheckCount() {
        let testString = Bundle.main.bundleIdentifier ?? "com.tigerspike.FlickrImageGallery"
        XCTAssertEqual(testString.isNonEmpty, testString.count > 0)
    }
    
    func testToDateNull() {
        XCTAssertNil("18.11.2017".toDate())
    }
    
    func testToDateNow() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssxxxxx"
        let now = formatter.string(from: Date()).toDate() ?? Date()
        XCTAssertLessThanOrEqual(now, Date())
    }
    
    func testGetAuthorNameEmpty() {
        XCTAssertTrue("".getAuthorName().isEmpty)
    }
    
    func testGetAuthorNameCorrect() {
        XCTAssertEqual("nobody@flickr.com (\"barisozr\")".getAuthorName(), "barisozr")
    }
    
    func testGetAuthorNameCorrect2() {
        XCTAssertEqual(" (\"barisozr\")".getAuthorName(), "barisozr")
    }
    
    func testGetAuthorNameCorrect3() {
        XCTAssertEqual("nobody@flickr.com (\"Jo\\u00e3o Antonio\")".getAuthorName(), "João Antonio")
    }
    
    //MARK: Date Extension Tests
    
    func testToStringCorrect() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let now = Date()
        XCTAssertEqual(now.toString(), formatter.string(from: now))
    }
    
    //MARK: Data Extension Tests
    func testToDictionaryNull() {
        let data = "test".data(using: String.Encoding.utf8) ?? Data()
        XCTAssertNil(data.toDictionary())
    }
    
    func testToDictionaryCorrect() {
        if let data = "{\"name\":\"Barış\", \"surname\":\"ÖZER\"}".data(using: String.Encoding.utf8), let dict = data.toDictionary() {
            XCTAssertEqual(dict.count, 2)
        }
    }
    
}
