//
//  LeaguesNetworkManager.swift
//  Sports
//
//  Created by Mohamed Mahgoub on 12/08/2024.
//

import Foundation
import Alamofire

protocol NetworkManagerProtocol {
    func getDataFromAPI<generic : Codable>(metValue : APIValidation,teamId : Int,firstTeamId:Int,secondTeamId: Int, type: generic.Type , sport : String ,handler : @escaping (generic?) -> Void)
}

let apiKey = "2c28d4947373c9aad33c4b48c0f99c79ce4469f4c59f207b0ee9d8f73d2ae9e2"

class NetworkManager : NetworkManagerProtocol {
    let params = param()
    
    func getDataFromAPI<generic : Codable>(metValue : APIValidation,teamId : Int,firstTeamId:Int,secondTeamId: Int, type: generic.Type , sport : String ,handler : @escaping (generic?) -> Void) {
   
        let url = URL(string: "https://apiv2.allsportsapi.com/\(sport)")
        guard let url = url else { return }
        let param = params.getParam(metValue : metValue, teamId: teamId,firstTeamId:firstTeamId,secondTeamId: secondTeamId)
        let request = AF.request(url, method: .get, parameters: param, encoding: URLEncoding.default)
        request.responseData { responseData in
            switch responseData.result {
            case .success(let data) :
                do{
                    let jsonDecoder = JSONDecoder()
                    let data = try jsonDecoder.decode(type, from: data)
                    handler(data)
                }catch{
                    print("Error : ",error.localizedDescription)
                }
            case .failure( let error):
                print("Error : ",error.localizedDescription)
            }
        }
    }
}

class param {
    func getParam(metValue : APIValidation,teamId : Int = 0,firstTeamId:Int,secondTeamId: Int) -> [String: String] {
        
        switch metValue {
        case .teamsDetails :
            return ["met" : metValue.rawValue,"teamId" : "\(teamId)","APIkey" : apiKey]
        case .H2H:
            return ["met" : metValue.rawValue,"APIkey" : apiKey,"firstTeamId" : "\(firstTeamId)","secondTeamId" : "\(secondTeamId)"]
        default :
            return ["met" : metValue.rawValue,"APIkey" : apiKey]
            
        }
    }
}
enum APIValidation : String {
    
    case sports = "Sports"
    case leagues = "Leagues"
    case leaguesDetails = "LeaguesDetails"
    case teamsDetails = "Teams"
    case H2H = "H2H"
}

