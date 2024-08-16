//
//  LeaguesNetworkManager.swift
//  Sports
//
//  Created by Mohamed Mahgoub on 12/08/2024.
//

import Foundation
import Alamofire

protocol NetworkManagerProtocol {
    func getLeaguesFromAPI<generic : Codable>(type: generic.Type , sport : String ,handler : @escaping (generic?) -> Void)
}

class NetworkManager : NetworkManagerProtocol {
    
    func getLeaguesFromAPI<generic : Codable>(type: generic.Type , sport : String ,handler : @escaping (generic?) -> Void) {
        let apiKey = "2c28d4947373c9aad33c4b48c0f99c79ce4469f4c59f207b0ee9d8f73d2ae9e2"
        let url = URL(string: "https://apiv2.allsportsapi.com/\(sport)")
        guard let url = url else { return }
        var param : [String : String] = [:]
        param = ["met" : "Leagues","APIkey" : apiKey]
        let request = AF.request(url, method: .get, parameters: param, encoding: URLEncoding.default)
        request.responseData { responseData in
            switch responseData.result {
            case .success(let data) :
                do{
                    let jsonDecoder = JSONDecoder()
                    let data = try jsonDecoder.decode(type, from: data)
                    handler(data)
                }catch{
                    print("Error")
                }
            case .failure(_):
                print("Error")
            }
        }
    }
}


