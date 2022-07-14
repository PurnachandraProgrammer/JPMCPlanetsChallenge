//  JPMCPlanetsChallenge
//  Created by purnachandra rao obulasetty on 11/07/2022.

import Foundation
import CoreData

extension CDPlanet {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDPlanet> {
        return NSFetchRequest<CDPlanet>(entityName: "CDPlanet")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var planetName: String?
}

extension CDPlanet : Identifiable {

}
