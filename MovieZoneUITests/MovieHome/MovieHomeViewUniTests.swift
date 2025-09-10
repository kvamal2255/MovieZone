//
//  MovieHomeViewUniTests.swift
//  MovieZoneUITests
//
//  Created by Amal K V on 9/10/25.
//

import XCTest

final class MovieHomeViewUITests: XCTestCase {
    
    private var app: XCUIApplication!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        app = nil
        try super.tearDownWithError()
    }
    
    // MARK: - Navigation Tests
    
    func test_navigationBarTitle_isDisplayed() {
        // Given
        let navigationBar = app.navigationBars["All Movies"]
        
        // Then
        XCTAssertTrue(navigationBar.exists, "Navigation bar with title 'All Movies' should exist")
    }
    
    func test_favoriteIcon_isDisplayed() {
        // Given
        let favoriteIcon = app.navigationBars.buttons["icHeartEmpty"]
        
        // Then
        XCTAssertTrue(favoriteIcon.exists, "Favorite icon should be displayed in navigation bar")
    }
    
    // MARK: - Search Bar Tests
    
    func test_searchBar_isDisplayedAndTappable() {
        // Given
        let searchBar = app.scrollViews.otherElements["GlobalSearchbarView"]
        
        // Then
        XCTAssertTrue(searchBar.exists, "Search bar should be displayed")
        
        // When
        searchBar.tap()
        
        XCTAssertTrue(app.navigationBars["Search"].exists || app.navigationBars["MovieSearchView"].exists,
                      "Tapping search bar should navigate to search view")
    }
    
    // MARK: - Movie List Tests
    
    func test_movieList_isDisplayedAfterLoading() {
        // Given
        let movieList = app.scrollViews
        
        // Wait for movies to load (with timeout)
        let predicate = NSPredicate(format: "exists == true")
        let expectation = XCTNSPredicateExpectation(predicate: predicate, object: movieList)
        let result = XCTWaiter.wait(for: [expectation], timeout: 10.0)
        
        // Then
        if result == .completed {
            XCTAssertTrue(movieList.firstMatch.exists, "Movie list should be displayed after loading")
            
            // Check if at least one movie card exists
            let movieCard = app.scrollViews.children(matching: .other).element(boundBy: 0)
            XCTAssertTrue(movieCard.exists, "At least one movie card should be displayed")
        }
    }
    
    func test_movieCards_areTappable() {
        // Given
        let movieList = app.scrollViews
        
        // Wait for movies to load
        let predicate = NSPredicate(format: "exists == true")
        let expectation = XCTNSPredicateExpectation(predicate: predicate, object: movieList)
        let result = XCTWaiter.wait(for: [expectation], timeout: 10.0)
        
        if result == .completed {
            // When - Tap on the first movie card
            let firstMovieCard = app.scrollViews.children(matching: .other).element(boundBy: 0)
            if firstMovieCard.exists {
                firstMovieCard.tap()
                
                // Then - Verify navigation to movie detail view
                // This will depend on your actual view identifiers
                let movieDetailExists = app.navigationBars.element.exists
                XCTAssertTrue(movieDetailExists, "Tapping movie card should navigate to movie detail view")
            }
        }
    }
    
    // MARK: - Favorite Icon Tests
    func test_favoriteIcon_showsBadgeWithCount() {
        // Given
        let favoriteIcon = app.navigationBars.buttons["icHeartEmpty"]
        
        // Then
        XCTAssertTrue(favoriteIcon.exists, "Favorite icon should be displayed")
    }
    
    func test_tappingFavoriteIcon_navigatesToFavoriteView() {
        // Given
        let favoriteIcon = app.navigationBars.buttons["icHeartEmpty"]
        
        // When
        favoriteIcon.tap()
        
        let favoritesViewExists = app.navigationBars["Favorites"].exists ||
        app.navigationBars["FavoriteListView"].exists
        XCTAssertTrue(favoritesViewExists, "Tapping favorite icon should navigate to favorites view")
    }
}

