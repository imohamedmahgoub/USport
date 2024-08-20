//
//  LeaguesViewModelTest.swift
//  UsportTests
//
//  Created by Mohamed Mahgoub on 20/08/2024.
//
import Foundation

import XCTest
@testable import Usport

class LeaguesViewModelTests: XCTestCase {
    var viewModel: LeaguesViewModel!
    var mockNetworkManager: MockNetworkManager!
    var mockCoreDataManager: MockCoreDataManager!

    override func setUp() {
        super.setUp()
        mockNetworkManager = MockNetworkManager()
        mockCoreDataManager = MockCoreDataManager()
        viewModel = LeaguesViewModel(sport: "football", networkManager: mockNetworkManager, coreDataManager: mockCoreDataManager, path: 0)
    }

    override func tearDown() {
        viewModel = nil
        mockNetworkManager = nil
        mockCoreDataManager = nil
        super.tearDown()
    }
    
    func testGetData_NonFavoriteCase_Success() {
        // Given
        let expectedData = LeaguesResponse(success: 1, result: [Leagues(leagueKey: 1, leagueName: "Premier League", leagueLogo: "logo.png")])
        mockNetworkManager.mockData = expectedData
        viewModel.isFav = false

        let expectation = self.expectation(description: "Data binding expectation")

        viewModel.bindDataToViewController = {
            expectation.fulfill()
        }

        // When
        viewModel.getData()

        // Then
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertEqual(viewModel.leagues.count, 1)
        XCTAssertEqual(viewModel.leagues.first?.leagueName, "Premier League")
    }

    func testGetData_NonFavoriteCase_Failure() {
        mockNetworkManager.shouldReturnError = true
        viewModel.isFav = false

        let expectation = self.expectation(description: "Data binding expectation")

        viewModel.bindDataToViewController = {
            expectation.fulfill()
        }

        viewModel.getData()

        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertEqual(viewModel.leagues.count, 0)
    }
}
