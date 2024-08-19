//
//  viewmodel.swift
//  la liga
//
//  Created by Ahmed El Gndy on 16/08/2024.
//

import Foundation

class LeaguesDetailsViewModel {
    
    var selectedLeague: Leagues? 
    var events: [Event] = []
    var homeTeams: [HomeTeamDetails] = []
    
    var reloadCollectionView: (() -> Void)?
    
    private let networkManager = NetworkManager()
    private let coreDataManager = CoreDataManager()
    
    func loadData() {
        
        guard let key = selectedLeague?.leagueKey else { return }
        networkManager.getDataFromAPI(metValue: .fixtures, teamId: 0, fromDate: "2023-08-17", toDate: "2024-08-17", leagueId: "\(key)", type: EventsResponse.self, sport: "football") { [weak self] result in
            guard let self = self else { return }
            if result?.success == 1 {
                self.events = result!.result
                
                let temp = self.events.map { event in
                    HomeTeamDetails(
                        homeTeamKey: event.homeTeamKey,
                        homeTeamName: event.eventHomeTeam ?? "",
                        homeTeamLogo: event.homeTeamLogo ?? " "
                    )
                }
                self.homeTeams = Array(Set(temp))
                
                DispatchQueue.main.async {
                    self.reloadCollectionView?()
                }
            }
        }
    }
    
       func toggleFavoriteStatus() {
           print("loooooooooooooood")
           print(selectedLeague?.leagueKey)
           print(selectedLeague?.leagueLogo)
           guard let leagueKey = selectedLeague?.leagueKey else { return }
           let   leagueName = selectedLeague?.leagueName
            let leagueLogo = selectedLeague?.leagueLogo
           let league = Leagues(leagueKey: leagueKey, leagueName: leagueName, leagueLogo: leagueLogo)
           coreDataManager.favToggle(league: league)
       }
       
       func isFavorite() -> Bool {
           guard let leagueKey = selectedLeague?.leagueKey else { return false }
           return coreDataManager.isFav(leagueKey: leagueKey)
       }
       
       func getFavoriteLeagues() -> [FavouriteLeague] {
           return coreDataManager.fetchFavouriteLeagues()
       }
   }

