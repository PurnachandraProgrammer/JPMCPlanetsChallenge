import Foundation
import CoreData

extension CDPlanet {
    
    // create fetch request
    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDPlanet> {
        return NSFetchRequest<CDPlanet>(entityName: "CDPlanet")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var planetName: String?
}

extension CDPlanet : Identifiable {

}
