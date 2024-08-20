//
//  Mock.swift
//  UsportTests
//
//  Created by Mohamed Mahgoub on 20/08/2024.
//

import Foundation
@testable import Usport

import XCTest

class MockNetworkManager: NetworkManagerProtocol {
    var shouldReturnError = false
    var mockData: Codable?

    func getDataFromAPI<generic : Codable>(metValue : APIValidation, teamId : Int, fromDate : String, toDate : String, leagueId : String, type: generic.Type, sport : String, handler : @escaping (generic?) -> Void) {
        
        if shouldReturnError {
            handler(nil)
        } else {
            handler(mockData as? generic)
        }
    }
}

class MockCoreDataManager: CoreDataManagerProtocol {
    var favoriteLeagues: [FavouriteLeague] = []
    var isFavorite = false

    func isFav(leagueKey: Int?) -> Bool {
        return isFavorite
    }

    func favToggle(league: Leagues) {
        if let leagueKey = league.leagueKey {
            isFavorite.toggle()
        }
    }

    func fetchFavouriteLeagues() -> [FavouriteLeague] {
        return favoriteLeagues
    }
}

