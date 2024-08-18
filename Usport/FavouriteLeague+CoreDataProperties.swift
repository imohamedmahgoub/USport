//
//  FavouriteLeague+CoreDataProperties.swift
//  coredata
//
//  Created by Ahmed El Gndy on 17/08/2024.
//
//

import Foundation
import CoreData

public class FavouriteLeagueEntity: NSManagedObject {

}

extension FavouriteLeagueEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavouriteLeagueEntity> {
        return NSFetchRequest<FavouriteLeagueEntity>(entityName: "FavouriteLeague")
    }

    @NSManaged public var leagueKey: Int64
    @NSManaged public var leagueName: String?
    @NSManaged public var leagueLogo: String?
}
