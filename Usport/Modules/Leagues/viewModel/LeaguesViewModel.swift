
//
//  ViewModel.swift
//  Sports
//
//  Created by Mohamed Mahgoub on 13/08/2024.
//

import Foundation

protocol LeaguesViewModelProtocol : AnyObject{
    var leagues : [Leagues] { get set }
    var bindDataToViewController: (()->()) { get set  }
    func getData()
}

class LeaguesViewModel: LeaguesViewModelProtocol {
    
    var path:Int
    var sport : String
    var leagues : [Leagues] = []
    var networkManager : NetworkManagerProtocol
    var bindDataToViewController: (() -> ()) = {}
    
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
        
        networkManager.getLeaguesFromAPI(sport: sport) {[weak self] leagues in
            guard let self else { return }
            self.leagues = leagues
            self.bindDataToViewController()
        }
    }

    
}
