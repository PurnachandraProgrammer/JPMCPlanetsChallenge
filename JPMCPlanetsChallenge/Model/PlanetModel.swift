import Foundation

// MARK: - PlanetResults
 struct PlanetResults:Codable {
    
    let count:Int
    let next:String
    let previous:String?
    let results:[Planet]?
}


// MARK: - Planet
struct Planet:Codable {
    let name:String;
}


