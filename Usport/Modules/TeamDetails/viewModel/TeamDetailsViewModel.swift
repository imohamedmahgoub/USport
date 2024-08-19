//
//  viewModel.swift
//  Sports
//
//  Created by Mohamed Mahgoub on 13/08/2024.
//

import Foundation
protocol TeamDetailsViewModelProtocol: AnyObject {
    var teamId : Int? { get set }
    var team:[Teams] { get }
    var playerList : [Players] {get set}
    func getData()
    var bindDataToTVC : (()->()) { get set }
}

class TeamDetailsViewModel: TeamDetailsViewModelProtocol {
    var bindDataToTVC: (() -> ()) = {}
    var path: Int
    var sport : String
    var team:[Teams] = []
    var playerList : [Players] = []
    var teamId : Int?
    var networkManager : NetworkManagerProtocol
    init(sport: String = "football",networkManager: NetworkManagerProtocol = NetworkManager() ,path :Int = 0 ){
        self.sport = sport
        self.networkManager = networkManager
        self.path = path
        self.didSelectSport()
    }
    func didSelectSport(){
        switch path {
        case 0 :
            sport = "football"
        case 1 :
            sport = "basketball"
        case 2 :
            sport = "cricket"
        case 3 :
            sport = "tennis"
        default:
            sport = "football"
        }
    }
    func getData() {
        getData(type:TeamsResponse.self, sport: sport, handler:{[weak self] teams in
            guard let self else { return }
            self.team = teams?.result ?? []
            self.playerList = teams?.result[0].players ?? []
            self.bindDataToTVC()
        })
    }
    
    private func getData<generic : Codable>(type: generic.Type , sport : String ,handler : @escaping (generic?) -> Void) {
        if InternetConnection.hasInternetConnect() {
            networkManager.getDataFromAPI(metValue: .teamsDetails, teamId: teamId ?? 100, fromDate: "", toDate: "", leagueId: "", type: type, sport: sport, handler: handler)
        }else {
            print("no internet")
        }
    }
}
