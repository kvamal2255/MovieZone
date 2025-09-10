//
//  DummyServiceTest.swift
//  MovieZoneTests
//
//  Created by Amal K V on 9/10/25.
//

import XCTest
@testable import MovieZone
import Combine

final class DummyServiceTest: XCTestCase {
    
    var mock: MockDummyService!
    var cancellable = Set<AnyCancellable>()
    override func setUpWithError() throws {
        mock = MockDummyService()
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        mock = nil
        try super.tearDownWithError()
    }
    
    func test_DummyService_usersList_countshouldGreaterthenZero() {
        // Given        
        let moviedetail = [MovieDetailData(id: "test1", title: "test movie", description: "test description", imageDetail: [], releaseDate: nil, genres: [], averageRating: 5.0, runtimeMinutes: 100, primaryImage: "", productionCompanies: [], directors: [], cast: [])]
        mock.movieStateSub = .success(moviedetail)
        // When
        let movieList = mock.getMovieList()
        // Then
        XCTAssertNotNil(movieList)
        XCTAssertNotNil(moviedetail)
        XCTAssertEqual(moviedetail.count, 1)
        XCTAssertEqual(moviedetail[0].title, "test movie")
    }
}

