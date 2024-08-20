//
//  TestLeagueDeatilsModel.swift
//  UsportTests
//
//  Created by Ahmed El Gndy on 20/08/2024.
//

import XCTest
@testable import Usport

final class TestLeagueDeatilsModel: XCTestCase {
    
    var viewModel: LeaguesDetailsViewModel!
    
    override func setUpWithError() throws {
        viewModel = LeaguesDetailsViewModel()
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
    }
    
    func testUpComingEvents() throws {
        let expectation = XCTestExpectation(description: "GET upcoming events")
        viewModel.selectedLeague = Leagues(leagueKey: 666, leagueName: "Gendy", leagueLogo: nil)
        viewModel.reloadCollectionView = {
            XCTAssertGreaterThan(self.viewModel.upComingEvents.count, 0)
            expectation.fulfill()
        }
        viewModel.loadUpcomingEvents()
        wait(for: [expectation],timeout: 10)
    }
    
    func testLatestEvents() throws {
        let expectation = XCTestExpectation(description: "GET latest events")
        viewModel.selectedLeague = Leagues(leagueKey: 1, leagueName: "Gendy", leagueLogo: nil)
        viewModel.reloadCollectionView = {
            XCTAssertGreaterThan(self.viewModel.events.count, 0)
            expectation.fulfill()
        }
        viewModel.loadData()
        wait(for: [expectation],timeout: 10)
    }
  
    
    func testTeamsSection() throws {
        let expectation = XCTestExpectation(description: "create a team")
        viewModel.selectedLeague = Leagues(leagueKey: 1, leagueName: "Gendy", leagueLogo: nil)
        viewModel.reloadCollectionView = {
            XCTAssertEqual(self.viewModel.events[0].eventHomeTeam, "Spain")
            expectation.fulfill()
        }
        viewModel.loadData()
        viewModel.isFavorite()
        viewModel.getFavoriteLeagues()
        wait(for: [expectation], timeout: 5)
    }
    func testGetAllData() {
        
    }
}
