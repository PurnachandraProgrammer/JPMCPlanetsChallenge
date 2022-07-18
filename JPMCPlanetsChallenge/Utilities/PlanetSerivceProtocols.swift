import Foundation

// Methods for Base protocol
protocol PlanetBaseService {
    func getPlanetRecords(completionHandler:@escaping(_ result: Array<Planet>?)->Void)
}

// PlanetCoreDataService protocol for core data
protocol PlanetCoreDataService : PlanetBaseService {
    func insertPlanetRecords(records:Array<Planet>,completionHandler: @escaping (_ error:Error?) -> Void)
}

// PlanetApiResourceService protocol for Apiresource
protocol PlanetApiResourceService : PlanetBaseService {

}
