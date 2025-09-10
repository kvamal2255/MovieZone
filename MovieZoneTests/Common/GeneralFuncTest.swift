//
//  GeneralFuncTest.swift
//  MovieZoneTests
//
//  Created by Amal K V on 9/10/25.
//

import XCTest
@testable import MovieZone

final class GeneralFuncTest: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // MARK: - formatRuntime Tests
    
    func test_formatRuntime_withZeroMinutes_returnsEmptyString() {
        let minutes = 0
        let result = formatRuntime(minutes: minutes)
        XCTAssertEqual(result, "")
    }
    
    func test_formatRuntime_withMinutesLessThanHour_returnsMinutesOnly() {
        let minutes = 45
        let result = formatRuntime(minutes: minutes)
        XCTAssertEqual(result, "45min")
    }
    
    func test_formatRuntime_withExactHours_returnsHoursOnly() {
        let minutes = 120 // 2 hours
        let result = formatRuntime(minutes: minutes)
        XCTAssertEqual(result, "2h")
    }
    
    func test_formatRuntime_withHoursAndMinutes_returnsFormattedString() {
        let minutes = 169 // 2 hours and 49 minutes
        let result = formatRuntime(minutes: minutes)
        XCTAssertEqual(result, "2h 49min")
    }
    
    func test_formatRuntime_withSingleHourAndMinutes_returnsFormattedString() {
        let minutes = 75 // 1 hour and 15 minutes
        let result = formatRuntime(minutes: minutes)
        XCTAssertEqual(result, "1h 15min")
    }
    
    func test_formatRuntime_withSingleMinute_returnsMinuteOnly() {
        let minutes = 1
        let result = formatRuntime(minutes: minutes)
        XCTAssertEqual(result, "1min")
    }
    
    // MARK: - formatDate Tests
    
    func test_formatDate_withValidDateString_returnsFormattedString() {
        let dateString = "2025-09-05"
        let result = formatDate(date: dateString)
        XCTAssertEqual(result, "Sep 2025")
    }
    
    func test_formatDate_withInvalidDateString_returnsSameString() {
        let dateString = "invalid-date"
        let result = formatDate(date: dateString)
        XCTAssertEqual(result, "invalid-date")
    }
    
    func test_formatDate_withEmptyString_returnsEmptyString() {
        let dateString = ""
        let result = formatDate(date: dateString)
        XCTAssertEqual(result, "")
    }
    
    func test_formatDate_withDifferentMonths_returnsCorrectFormattedString() {
        
        let testCases = [
            ("2025-01-15", "Jan 2025"),
            ("2025-02-15", "Feb 2025"),
            ("2025-03-15", "Mar 2025"),
            ("2025-04-15", "Apr 2025"),
            ("2025-05-15", "May 2025"),
            ("2025-06-15", "Jun 2025"),
            ("2025-07-15", "Jul 2025"),
            ("2025-08-15", "Aug 2025"),
            ("2025-09-15", "Sep 2025"),
            ("2025-10-15", "Oct 2025"),
            ("2025-11-15", "Nov 2025"),
            ("2025-12-15", "Dec 2025")
        ]
        
        for (input, expected) in testCases {
            let result = formatDate(date: input)
            XCTAssertEqual(result, expected, "Failed for input date: \(input)")
        }
    }
}
