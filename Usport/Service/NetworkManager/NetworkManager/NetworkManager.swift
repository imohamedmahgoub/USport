//
//  LeaguesNetworkManager.swift
//  Sports
//
//  Created by Mohamed Mahgoub on 12/08/2024.
//

import Foundation
import Alamofire

protocol NetworkManagerProtocol {
    func getDataFromAPI<generic : Codable>(metValue : APIValidation,teamId : Int,fromDate : String,toDate : String, leagueId : String,type: generic.Type , sport : String ,handler : @escaping (generic?) -> Void)
}

let apiKey = "2c28d4947373c9aad33c4b48c0f99c79ce4469f4c59f207b0ee9d8f73d2ae9e2"


class NetworkManager : NetworkManagerProtocol {
    let params = param()
    
    func getDataFromAPI<generic : Codable>(metValue : APIValidation,teamId : Int,fromDate : String,toDate : String, leagueId : String, type: generic.Type , sport : String ,handler : @escaping (generic?) -> Void) {
   
        let url = URL(string: "https://apiv2.allsportsapi.com/\(sport)")
        guard let url = url else { return }
        let param = params.getParam(metValue : metValue, teamId: teamId,from : fromDate,to : toDate, leagueId : leagueId)
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
    func getParam(metValue : APIValidation,teamId : Int,from : String,to : String, leagueId : String) -> [String: String] {
        switch metValue {
        case .teamsDetails :
            return ["met" : metValue.rawValue,"teamId" : "\(teamId)","APIkey" : apiKey]
        case .fixtures :
            if from == "" {
                return ["met" : metValue.rawValue,"leagueId" :"\(leagueId)", "APIkey" : apiKey]
            }else{
                return ["met" : metValue.rawValue,"leagueId" :"\(leagueId)","from":"\(from)","to":"\(to)",  "APIkey" : apiKey]
            }
        default :
            return ["met" : metValue.rawValue,"APIkey" : apiKey]
        }
    }
}
enum APIValidation : String {
    case leagues = "Leagues"
    case teamsDetails = "Teams"
    case fixtures = "Fixtures"
}

