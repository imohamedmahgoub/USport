//
//  TeamDetailsViewModelTest.swift
//  UsportTests
//
//  Created by Mohamed Mahgoub on 20/08/2024.
//

import Foundation

import XCTest
@testable import Usport


class TeamDetailsViewModelTests: XCTestCase {

    var viewModel: TeamDetailsViewModel!
    var mockNetworkManager: MockNetworkManager!
    
    override func setUp() {
        super.setUp()
        mockNetworkManager = MockNetworkManager()
        viewModel = TeamDetailsViewModel(sport: "football", networkManager: mockNetworkManager, path: 0)
    }
    
    override func tearDown() {
        viewModel = nil
        mockNetworkManager = nil
        super.tearDown()
    }
    
    func testGetData_FetchesTeamDetailsSuccessfully() {
        // Given
        let expectedPlayers = [Players(playerKey: 1, playerImage: nil, playerName: "Player 1", playerNumber: nil, playerCountry: nil, playerType: nil, playerAge: nil)]
        let expectedTeams = [Teams(teamKey: 96, teamName: "Team A", teamLogo: nil, players: expectedPlayers, coaches: nil)]
        let teamsResponse = TeamsResponse(success: 1, result: expectedTeams)
        mockNetworkManager.mockData = teamsResponse
        
        let expectation = self.expectation(description: "bindDataToTVC should be called")
        viewModel.bindDataToTVC = {
            expectation.fulfill()
        }
        
        // When
        viewModel.getData()
        
        // Then
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertEqual(viewModel.team.count, expectedTeams.count)
        XCTAssertEqual(viewModel.playerList.count, expectedPlayers.count)
        XCTAssertEqual(viewModel.team.first?.teamName,expectedTeams.first?.teamName)
        XCTAssertEqual(viewModel.playerList.first?.playerName, expectedPlayers.first?.playerName)
    }
    
    func testDidSelectSport_ChangesSportBasedOnPath() {
        // Given
        let footballPath = 0
        let basketballPath = 1
        let cricketPath = 2
        let tennisPath = 3
        let defaultPath = 4
        
        // When
        viewModel = TeamDetailsViewModel(sport: "football", networkManager: mockNetworkManager, path: footballPath)
        XCTAssertEqual(viewModel.sport, "football")
        
        viewModel = TeamDetailsViewModel(sport: "basketball", networkManager: mockNetworkManager, path: basketballPath)
        XCTAssertEqual(viewModel.sport, "basketball")
        
        viewModel = TeamDetailsViewModel(sport: "cricket", networkManager: mockNetworkManager, path: cricketPath)
        XCTAssertEqual(viewModel.sport, "cricket")
        
        viewModel = TeamDetailsViewModel(sport: "tennis", networkManager: mockNetworkManager, path: tennisPath)
        XCTAssertEqual(viewModel.sport, "tennis")
        
        viewModel = TeamDetailsViewModel(sport: "football", networkManager: mockNetworkManager, path: defaultPath)
        XCTAssertEqual(viewModel.sport, "football")
    }
}
