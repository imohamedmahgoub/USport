//
//  CoreDataManager.swift
//  Usport
//
//  Created by Ahmed El Gndy on 19/08/2024.
//

import Foundation
import CoreData
import UIKit

protocol CoreDataManagerProtocol {
    func isFav(leagueKey: Int?) -> Bool
    func favToggle(league: Leagues)
}

class CoreDataManager: CoreDataManagerProtocol {
    let context: NSManagedObjectContext
    
    init() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
    }
    
    // Save the league as a favorite
    func saveFavouriteLeague(league: Leagues) {
        guard let entity = NSEntityDescription.entity(forEntityName: "FavouriteLeague", in: context) else { return }
        let favouriteLeague = NSManagedObject(entity: entity, insertInto: context)
        
        favouriteLeague.setValue(league.leagueKey, forKey: "leagueKey")
        favouriteLeague.setValue(league.leagueName, forKey: "leagueName")
        favouriteLeague.setValue(league.leagueLogo, forKey: "leagueLogo")
        
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchFavouriteLeagues() -> [FavouriteLeagueEntity] {
        let fetchRequest = NSFetchRequest<FavouriteLeagueEntity>(entityName: "FavouriteLeague")
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print(error.localizedDescription)
        }
        return []
    }
    
    func removeFavouriteLeague(leagueKey: Int) {
        guard let index = fetchFavouriteLeagues().firstIndex(where: { $0.leagueKey == leagueKey }) else { return }
        
        self.context.delete(self.fetchFavouriteLeagues()[index])
        
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func isFav(leagueKey: Int?) -> Bool {
        guard let leagueKey = leagueKey else { return false }
        
        return fetchFavouriteLeagues().map({ Int($0.leagueKey) }).contains(leagueKey)
    }
    
    func favToggle(league: Leagues) {
        if let leagueKey = league.leagueKey {
            isFav(leagueKey: leagueKey) ? removeFavouriteLeague(leagueKey: leagueKey) : saveFavouriteLeague(league: league)
        }
    }
}
