//
//  CoreDataManagerTests.swift
//  UsportTests
//
//  Created by Ahmed El Gndy on 20/08/2024.
//

import XCTest
import CoreData
@testable import Usport


class CoreDataManagerTests: XCTestCase {
    
    var coreDataManager: CoreDataManager!
    
    override func setUpWithError() throws {
        coreDataManager = CoreDataManager()
    }
    
    override func tearDownWithError() throws {
        coreDataManager = nil
    }
    
    func testSaveFavouriteLeague() throws {
        let league = Leagues(leagueKey: 1, leagueName: "Premier League", leagueLogo: "premier_league_logo")
        coreDataManager.saveFavouriteLeague(league: league)
        XCTAssertTrue(coreDataManager.isFav(leagueKey: 1))
    }
    
    func testFetchFavouriteLeagues() throws {
        let league = Leagues(leagueKey: 2, leagueName: "La Liga", leagueLogo: "la_liga_logo")
        coreDataManager.saveFavouriteLeague(league: league)
        let fetchedLeagues = coreDataManager.fetchFavouriteLeagues()
        XCTAssertEqual(fetchedLeagues.last?.leagueKey, 2)
    }
    
    func testRemoveFavouriteLeague() throws {
        let league = Leagues(leagueKey: 3, leagueName: "Premier League", leagueLogo: "premier_league_logo")
        
        coreDataManager.saveFavouriteLeague(league: league)
        coreDataManager.removeFavouriteLeague(leagueKey: 3)
        
        XCTAssertFalse(coreDataManager.isFav(leagueKey: 3))
    }
    
    func testFavToggle() throws {
        let league = Leagues(leagueKey: 4, leagueName: "Premier League", leagueLogo: "premier_league_logo")
        coreDataManager.saveFavouriteLeague(league: league)
        XCTAssertTrue(coreDataManager.isFav(leagueKey: league.leagueKey))
        coreDataManager.favToggle(league: league)
        XCTAssertFalse(coreDataManager.isFav(leagueKey: league.leagueKey))
    }
}
