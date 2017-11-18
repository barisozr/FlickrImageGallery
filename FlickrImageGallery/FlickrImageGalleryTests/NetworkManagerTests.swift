//
//  NetworkManagerTests.swift
//  FlickrImageGalleryTests
//
//  Created by Barış Özer on 11/18/17.
//  Copyright © 2017 Tigerspike. All rights reserved.
//

import XCTest
@testable import FlickrImageGallery

class NetworkManagerTests: XCTestCase {
    
    let timeout:TimeInterval = 10
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetPhotosCount() {
        let exp = expectation(description: #function)
        NetworkManager.sharedManager.getPhotos { (result) in
            XCTAssertNotNil(result)
            XCTAssertEqual(result?.count ?? 0, 20)
            exp.fulfill()
        }
        waitForExpectations(timeout: timeout, handler: nil)
    }
    
    func testDownloadImageNull() {
        let exp = expectation(description: #function)
        NetworkManager.downloadImage(url: URL(string: "https://farm1.staticflickr.com/4560/asda.jpg")) { (image) in
            XCTAssertNil(image)
            exp.fulfill()
        }
        waitForExpectations(timeout: timeout, handler: nil)
    }
    
    func testDownloadImageNotNull() {
        let exp = expectation(description: #function)
        NetworkManager.downloadImage(url: URL(string: "https://farm5.staticflickr.com/4531/38472482232_132162a17a_m.jpg")) { (image) in
            XCTAssertNotNil(image)
            exp.fulfill()
        }
        waitForExpectations(timeout: timeout, handler: nil)
    }
    
}
