import Foundation

extension CDPlanet {
    
    // Convert the Core data record to Planet object
    func convertToPlanet() -> Planet {
        return Planet(name: self.planetName ?? "",terrain: self.terrain ?? "",climate: self.climate ?? "")
    }
}
