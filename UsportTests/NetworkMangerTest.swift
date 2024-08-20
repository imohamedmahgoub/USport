//
//  NetworkMangerTest.swift
//  UsportTests
//
//  Created by Mohamed Mahgoub on 20/08/2024.
//
import Foundation

import XCTest
@testable import Usport

class NetworkManagerTests: XCTestCase {
    
    var networkManager: NetworkManager!
    var mockNetworkManager: MockNetworkManager!
    
    override func setUp() {
        super.setUp()
        networkManager = NetworkManager()
        mockNetworkManager = MockNetworkManager()
    }
    func testGetDataFromAPISuccessCase() {
        // Given
        let expectedData = Leagues(leagueKey: 305, leagueName: "", leagueLogo: "")
        mockNetworkManager.mockData = expectedData
        
        let expectation = self.expectation(description: "Success")
        
        // When
        mockNetworkManager.getDataFromAPI(metValue: .leagues, teamId: 96, fromDate: "", toDate: "", leagueId: "", type: Leagues.self, sport: "football") { data in
            // Then
            XCTAssertNotNil(data)
            XCTAssertEqual(data?.leagueKey, expectedData.leagueKey)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 7, handler: nil)
    }
    
    func testGetDataFromAPIFailureCase() {
        // Given
        mockNetworkManager.shouldReturnError = true
        
        let expectation = self.expectation(description: "Failure")
        
        // When
        mockNetworkManager.getDataFromAPI(metValue: .leagues, teamId: 1, fromDate: "", toDate: "", leagueId: "", type: Leagues.self, sport: "football") { data in
            // Then
            XCTAssertNil(data)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 7, handler: nil)
    }
    
    
    
    
    override func tearDown() {
        networkManager = nil
        mockNetworkManager = nil
        super.tearDown()
    }
    
}
