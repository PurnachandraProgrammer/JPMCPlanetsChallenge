//  PlanetsListViewModel.swift
//  JPMCPlanetsChallenge
//  Created by purnachandra rao obulasetty on 11/07/2022.

import Foundation

/// This class is main view model of this applicaiton.
public class PlanetsListViewModel {
    
    var planetsArray: Dynamic<[Planet]> = Dynamic([])
    var apiFetchError:Dynamic<Error?> = Dynamic(nil)
    
    private var planetsListService:PlanetBaseService!
    private var planetsCoredataService:PlanetCoreDataService!
    
    private var planetCellViewModels  = [PlanetTableViewCellViewModel]()
    //private var trackDetailViewModels = [TrackDetailViewModel]()
    
    init(planetsListService:PlanetBaseService?,coreDataService:PlanetCoreDataService) {
        self.planetsListService = planetsListService
        self.planetsCoredataService = coreDataService
    }
    
    /// Fetch tracks from the server using TracksListServiceProtocol
    func fetchPlanets(completionHandler: @escaping (Array<Planet>?,Error?) -> Void) {
        
        
        planetsCoredataService.getPlanetRecords(completionHandler: { result in
            
            if result != nil && result!.count > 0 {
                completionHandler(result,nil)
            }
            
            else {
                
                self.planetsListService.getPlanetRecords { planetRecords in
                    
                    if(planetRecords != nil && planetRecords?.count != 0){

                        _ = self.planetsCoredataService.batchInsertPlanetRecords(records: planetRecords!)
                        completionHandler(planetRecords,nil)

                    }

                    
                }

            }
            
        })
        /*
        else {
            completionHandler(nil,NSError(domain:"Planets list service is empty", code: 0, userInfo: nil))
            return
        }*/
    }
    
    /// Fetch tracks from the server and sort by release date.
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
    
    /// Returns the numer of tracks
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
