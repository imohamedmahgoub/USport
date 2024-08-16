//
//  Teams.swift
//  Sports
//
//  Created by Mohamed Mahgoub on 15/08/2024.
//

import Foundation

struct TeamsResponse : Codable {
    let success : Int
    let result : [Teams]

    enum CodingKeys: String, CodingKey {

        case success = "success"
        case result = "result"
    }
}

class Teams : Codable {
    let teamKey : Int?
    let teamName : String?
    let teamLogo : String?
    let players : [Players]?
    let coaches : [Coaches]?

    enum CodingKeys: String, CodingKey {
        case teamKey = "team_key"
        case teamName = "team_name"
        case teamLogo = "team_logo"
        case players = "players"
        case coaches = "coaches"
    }

}
class Players : Codable {
    let playerKey : Int?
    let playerImage : String?
    let playerName : String?
    let playerNumber : String?
    let playerCountry : String?
    let playerType : String?
    let playerAge : String?

    enum CodingKeys: String, CodingKey {

        case playerKey = "player_key"
        case playerImage = "player_image"
        case playerName = "player_name"
        case playerNumber = "player_number"
        case playerCountry = "player_country"
        case playerType = "player_type"
        case playerAge = "player_age"
       
    }
}
class Coaches : Codable {
    let coachName : String?
    let coachCountry : String?
    let coachAge : String?

    enum CodingKeys: String, CodingKey {

        case coachName = "coach_name"
        case coachCountry = "coach_country"
        case coachAge = "coach_age"
    }
}




