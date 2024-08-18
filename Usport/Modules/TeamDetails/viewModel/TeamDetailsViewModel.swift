//
//  viewModel.swift
//  Sports
//
//  Created by Mohamed Mahgoub on 13/08/2024.
//

import Foundation
protocol TeamDetailsViewModelProtocol: AnyObject {
    var teamsDetails : [HomeTeamDetails]{get set}
    var team:[Teams]? { get }
    func getData(_ handler2:@escaping([Teams])->Void)
}

class TeamDetailsViewModel: TeamDetailsViewModelProtocol {
    var path: Int
    var sport : String
    var team:[Teams]?
    var teamsDetails: [HomeTeamDetails] = []
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
    func getData(_ handler2:@escaping([Teams])->Void) {
        getData(type:TeamsResponse.self, sport: sport, handler:{[weak self] teams in
            guard let self else { return }
            self.team = teams!.result
            handler2(team!)
        })
    }
    
    private func getData<generic : Codable>(type: generic.Type , sport : String ,handler : @escaping (generic?) -> Void) {
        if InternetConnection.hasInternetConnect() {
            networkManager.getDataFromAPI(metValue: .teamsDetails, teamId: 96, fromDate: "", toDate: "", leagueId: "", type: type, sport: sport, handler: handler)
        }else {
            print("no internet")
        }
    }
}
