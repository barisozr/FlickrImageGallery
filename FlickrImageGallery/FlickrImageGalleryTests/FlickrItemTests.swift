//
//  FlickrItemTests.swift
//  FlickrImageGalleryTests
//
//  Created by Barış Özer on 11/18/17.
//  Copyright © 2017 Tigerspike. All rights reserved.
//

import XCTest
@testable import FlickrImageGallery

class FlickrItemTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func getDummyData() -> [String:Any] {
        return ["title": "DSC00547.jpg",
                "link": "https://www.flickr.com/photos/45885291@N04/26724710939/",
                "media": ["m": "https://farm5.staticflickr.com/4522/26724710939_607d22cab5_m.jpg"],
                "date_taken": "2017-11-18T12:56:22-08:00",
                "description": " <p><a href=\"https://www.flickr.com/people/45885291@N04/\">leoshop</a> posted a photo:</p> <p><a href=\"https://www.flickr.com/photos/45885291@N04/26724710939/\" title=\"DSC00547.jpg\"><img src=\"https://farm5.staticflickr.com/4522/26724710939_607d22cab5_m.jpg\" width=\"240\" height=\"160\" alt=\"DSC00547.jpg\" /></a></p> ",
                "published": "2017-11-18T14:19:31Z",
                "author": "nobody@flickr.com (\"leoshop\")",
                "author_id": "45885291@N04",
                "tags": ""]
    }
    
    func getDummyData2() -> [String:Any] {
        return ["title": "Early mornings pensiveness",
                "link": "https://www.flickr.com/photos/sreekrishnan/26724711419/",
                "media": ["m": "https://farm5.staticflickr.com/4580/26724711419_a7e8cffac3_m.jpg"],
                "date_taken": "2017-11-18T06:19:32-08:00",
                "description": " <p><a href=\"https://www.flickr.com/people/sreekrishnan/\">Sreekrishnan</a> posted a photo:</p> <p><a href=\"https://www.flickr.com/photos/sreekrishnan/26724711419/\" title=\"Early mornings pensiveness\"><img src=\"https://farm5.staticflickr.com/4580/26724711419_a7e8cffac3_m.jpg\" width=\"192\" height=\"240\" alt=\"Early mornings pensiveness\" /></a></p> <p>via Instagram <a href=\"http://ift.tt/2hCAGPW\" rel=\"nofollow\">ift.tt/2hCAGPW</a></p>",
                "published": "2017-11-18T14:19:32Z",
                "author": "nobody@flickr.com (\"Sreekrishnan\")",
                "author_id": "32030386@N06",
                "tags": "ifttt instagram"]
    }
    
    func testItemAuthor() {
        let item = FlickrItem(getDummyData())
        XCTAssertEqual(item.author ?? "", "leoshop")
    }
    
    func testItemLink() {
        let item = FlickrItem(getDummyData())
        XCTAssertEqual(item.link?.absoluteString ?? "", "https://www.flickr.com/photos/45885291@N04/26724710939/")
    }
    
    func testItemMedia() {
        let item = FlickrItem(getDummyData2())
        XCTAssertEqual(item.media?.absoluteString ?? "", "https://farm5.staticflickr.com/4580/26724711419_a7e8cffac3_m.jpg")
    }
    
    func testItemAuthorId() {
        let item = FlickrItem(getDummyData2())
        XCTAssertEqual(item.authorId ?? "", "32030386@N06")
    }
    
    func testItemTags() {
        let item = FlickrItem(getDummyData2())
        XCTAssertEqual(item.tags?.count ?? 0, 2)
    }
    
}
