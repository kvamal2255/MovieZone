//
//  EndpointTests.swift
//  MovieZoneTests
//
//  Created by Amal K V on 9/10/25.
//

import XCTest
@testable import MovieZone

final class EndpointTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_Endpoint_rootURL_shouldBeTrue() {
        
        let rootURL: String = "https://imdb236.p.rapidapi.com/api/imdb?"
        
        let endpoint = Endpoint(path: "")
        
        XCTAssertEqual(endpoint.url.absoluteString, rootURL)
    }
}
