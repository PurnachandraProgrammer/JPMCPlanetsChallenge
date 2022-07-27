//
//  CDPlanet+CoreDataProperties.swift
//  JPMCPlanetsChallenge
//
//  Created by purnachandra rao obulasetty on 27/07/2022.
//
//

import Foundation
import CoreData


extension CDPlanet {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDPlanet> {
        return NSFetchRequest<CDPlanet>(entityName: "CDPlanet")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var planetName: String?
    @NSManaged public var terrain: String?
    @NSManaged public var climate: String?

}

extension CDPlanet : Identifiable {

}
