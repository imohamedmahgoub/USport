//
//  LeaguesResponse.swift
//  Sports
//
//  Created by Mohamed Mahgoub on 12/08/2024.
//

import Foundation

struct LeaguesResponse: Codable{
    let success : Int
    let result: [Leagues]
}

class Leagues : Codable {
    
    var leagueKey: Int?
    var leagueName: String?
    var countryKey: Int?
    var countryName: String?
    var leagueLogo: String?
    var countryLogo: String?
    
    enum CodingKeys: String, CodingKey{
        case leagueKey = "league_key"
        case leagueName = "league_name"
        case countryKey = "country_key"
        case countryName = "country_name"
        case leagueLogo = "league_logo"
        case countryLogo = "country_logo"
    }
}


