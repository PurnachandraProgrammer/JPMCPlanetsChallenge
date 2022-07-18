import Foundation

/// This class is main view model of this applicaiton.
public class PlanetsListViewModel {
    
    var planetsArray: Dynamic<[Planet]> = Dynamic([])
    var apiFetchError:Dynamic<Error?> = Dynamic(nil)
    let reachability: Reachability = Reachability()
    
    private var planetsListService:PlanetBaseService!
    private var planetsCoredataService:PlanetCoreDataService!
    
    private var planetCellViewModels  = [PlanetTableViewCellViewModel]()
    
    init(planetsListService:PlanetBaseService?,coreDataService:PlanetCoreDataService) {
        self.planetsListService = planetsListService
        self.planetsCoredataService = coreDataService
    }
    
    /// Fetch planets from the server using PlanetBaseService protocol
    func fetchPlanets(completionHandler: @escaping (Array<Planet>?,Error?) -> Void) {
        
        // Fetch planets from the core data
        planetsCoredataService.getPlanetRecords(completionHandler: { result in
            
            // If records are not empty return to the controller
            if result != nil && result!.count > 0 {
                completionHandler(result,nil)
            }
            
            //If no records are available in core data, fetch from the server
            else {
                
                if self.reachability.isConnectedToNetwork() {
                    
                    self.planetsListService.getPlanetRecords { planetRecords in
                        
                        if(planetRecords != nil && planetRecords!.count > 0){
                            
                            _ = self.planetsCoredataService.insertPlanetRecords(records: planetRecords!)
                            completionHandler(planetRecords,nil)
                        }
                        
                        else {
                            completionHandler(nil,NSError(domain:"Planets list service is empty", code: 0, userInfo: nil))
                            return
                        }
                    }
                }
                else {
                    completionHandler(nil,NSError(domain:"Network is not available. Please connect to network", code: 0, userInfo: nil))
                    return
                }
            }
            
        })
    }
    
    /// Fetch planets from the server and sort by release date.
    func fetchPlanets() {
        
        self.fetchPlanets { results, error in
            
            if results != nil {
                
                self.processCellModels(results: results!)
                self.planetsArray.value = results!
            }
            else {
                self.apiFetchError.value = error
            }
            
        }
    }
    
    /// Returns the numer of planets
    func getNumberOfPlanets() -> Int {
        return planetCellViewModels.count
    }
    
    /// Returns view model for the tableview cell for the row/
    func getCellViewModel( at indexPath: IndexPath ) -> PlanetTableViewCellViewModel {
        return planetCellViewModels[indexPath.row]
    }
    
    func createCellViewModel( resultModel: Planet ) -> PlanetTableViewCellViewModel {
        
        return PlanetTableViewCellViewModel(planetName: resultModel.name)
        
        
    }
    
    private func processCellModels( results: [Planet] ) {
        
        var planetCellViewModels = [PlanetTableViewCellViewModel]()
        for result in results {
            planetCellViewModels.append( createCellViewModel(resultModel: result) )
        }
        self.planetCellViewModels = planetCellViewModels
    }
    
    
}
