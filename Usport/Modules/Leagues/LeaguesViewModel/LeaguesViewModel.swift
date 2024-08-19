
//
//  ViewModel.swift
//  Sports
//
//  Created by Mohamed Mahgoub on 13/08/2024.
//

import Foundation

protocol LeaguesViewModelProtocol {
    var leagues: [Leagues] { get set }
    var bindDataToViewController: (() -> Void) { get set }
    func getData()
    var isFav: Bool { get set }
}

class LeaguesViewModel: LeaguesViewModelProtocol {
    
    var path: Int
    var isFav: Bool = true
    var sport: String
    var leagues: [Leagues] = []
    var networkManager: NetworkManagerProtocol
    var bindDataToViewController: (() -> Void) = {}
    var coreDataManager: CoreDataManagerProtocol
    
    init(
        sport: String = "football",
        networkManager: NetworkManagerProtocol = NetworkManager(),
        coreDataManager: CoreDataManagerProtocol = CoreDataManager(),
        path: Int = 0
    ) {
        self.sport = sport
        self.networkManager = networkManager
        self.coreDataManager = coreDataManager
        self.path = path
        self.didSelectSport()
    }
    
    func didSelectSport() {
        sport = switch path {
        case 0:
            "football"
        case 1:
            "basketball"
        case 2:
            "cricket"
        case 3:
            "tennis"
        default:
            "football"
        }
    }
    
    func getData() {
        if isFav {
            handleFavoriteCase()
        } else {
            getData(type: LeaguesResponse.self, sport: sport) { [weak self] leagues in
                guard let self = self else { return }
                self.leagues = leagues?.result ?? []
                self.bindDataToViewController()
            }
        }
    }
    
    private func getData<generic: Codable>(type: generic.Type, sport: String, handler: @escaping (generic?) -> Void) {
        if InternetConnection.hasInternetConnect() {
            networkManager.getDataFromAPI(metValue: .leagues, teamId: 96, fromDate: "", toDate: "", leagueId: "", type: type, sport: sport, handler: handler)
        } else {
            print("no internet")
        }
    }
    
    private func handleFavoriteCase() {
        // Fetch favorite leagues from Core Data
        let favoriteLeagues = coreDataManager.fetchFavouriteLeagues()
        // Convert the fetched Core Data objects to your `FavoriteLeagueModel`
        let favoriteLeagueModels = favoriteLeagues.map { favoriteLeague in
            FavoriteLeagueModel(leagueKey: Int(favoriteLeague.leagueKey),
                                leagueName: favoriteLeague.leagueName,
                                leagueLogo: favoriteLeague.leagueLogo)
        }
        
        leagues = favoriteLeagueModels.map { leagueModel in
            Leagues(leagueKey: leagueModel.leagueKey,
                    leagueName: leagueModel.leagueName,
                    leagueLogo: leagueModel.leagueLogo)
        }
        print(leagues.count)
        bindDataToViewController()
    }
}
