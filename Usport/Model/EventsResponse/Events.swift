//
//  Events.swift
//  Usport
//
//  Created by Mohamed Mahgoub on 18/08/2024.
//

import Foundation

struct EventsResponse: Codable {
    let success: Int
    let result: [Event]
}

struct Event: Codable {
    let eventKey: Int
    let eventDate: String?
    let eventHomeTeam: String?
    let homeTeamKey: Int
    let eventAwayTeam: String?
    let awayTeamKey: Int
    let eventHalftimeResult, eventFinalResult, eventFtResult: String?
    let leagueKey: Int
    let homeTeamLogo, awayTeamLogo: String?

    enum CodingKeys: String, CodingKey {
        case eventKey = "event_key"
        case eventDate = "event_date"
        case eventHomeTeam = "event_home_team"
        case homeTeamKey = "home_team_key"
        case eventAwayTeam = "event_away_team"
        case awayTeamKey = "away_team_key"
        case eventHalftimeResult = "event_halftime_result"
        case eventFinalResult = "event_final_result"
        case eventFtResult = "event_ft_result"
        case leagueKey = "league_key"
        case homeTeamLogo = "home_team_logo"
        case awayTeamLogo = "away_team_logo"
       
    }
}
