//
//  viewmodel.swift
//  la liga
//
//  Created by Ahmed El Gndy on 16/08/2024.
//

import Foundation

class LeaguesDetailsViewModel {
    
    var key: Int?
    var events: [Event] = []
    var homeTeams: [HomeTeamDetails] = []
    
    var reloadCollectionView: (() -> Void)?
    
    private let networkManager = NetworkManager()
    
    func loadData() {
        guard let key = key else { return }
        networkManager.getDataFromAPI(metValue: .fixtures, teamId: 0, fromDate: "2023-08-17", toDate: "2024-08-17", leagueId: "\(key)", type: EventsResponse.self, sport: "football") { [weak self] result in
            guard let self = self else { return }
            if result?.success == 1 {
                self.events = result!.result
                
                self.homeTeams = self.events.map { event in
                    HomeTeamDetails(
                        homeTeamKey: event.homeTeamKey,
                        homeTeamName: event.eventHomeTeam ?? "",
                        homeTeamLogo: event.homeTeamLogo ?? " "
                    )
                }
                
                DispatchQueue.main.async {
                    self.reloadCollectionView?()
                }
            }
        }
    }
}
