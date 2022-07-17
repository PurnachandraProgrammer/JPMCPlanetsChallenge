import Foundation

protocol PlanetBaseService {
    func getPlanetRecords(completionHandler:@escaping(_ result: Array<Planet>?)->Void)
}

protocol PlanetCoreDataService : PlanetBaseService {
    func insertPlanetRecords(records:Array<Planet>) -> Bool
}

protocol PlanetApiResourceService : PlanetBaseService {

}
