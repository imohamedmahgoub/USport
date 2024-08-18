//
//  HomeTeamDetails.swift
//  Usport
//
//  Created by Ahmed El Gndy on 18/08/2024.
//

import Foundation
struct HomeTeamDetails: Hashable {
    let homeTeamKey: Int
    let homeTeamName: String
    let homeTeamLogo: String
    
    static func == (lhs: HomeTeamDetails, rhs: HomeTeamDetails) -> Bool {
        return lhs.homeTeamKey == rhs.homeTeamKey &&
               lhs.homeTeamName == rhs.homeTeamName &&
               lhs.homeTeamLogo == rhs.homeTeamLogo
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(homeTeamKey)
        hasher.combine(homeTeamName)
        hasher.combine(homeTeamLogo)
    }
}
