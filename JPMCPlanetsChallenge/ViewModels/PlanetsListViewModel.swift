//
//  TrackViewModel.swift
//  AppleTrackTest
//
//  Created by purnachandra rao obulasetty on 26/11/2021.
//

import Foundation

/// This class is main view model of this applicaiton.
public class PlanetsListViewModel {
    
    var planetsArray: Dynamic<[Planet]> = Dynamic([])
    var apiFetchError:Dynamic<Error?> = Dynamic(nil)
    
    private var planetsListService:PlanetsListServiceProtocol?
    
    private var planetCellViewModels  = [PlanetTableViewCellViewModel]()
    //private var trackDetailViewModels = [TrackDetailViewModel]()
    
    init(planetsListService:PlanetsListServiceProtocol?) {
        self.planetsListService = planetsListService
    }
    
    /// Fetch tracks from the server using TracksListServiceProtocol
    func fetchPlanets(completionHandler: @escaping (PlanetResults?,Error?) -> Void) {
        
        if let planetsListService = planetsListService {
            
            planetsListService.fetchPlanets() { resultObject, error in
                print("The object is \(String(describing: resultObject))")
                completionHandler(resultObject,error)
            }
        }
        
        else {
            completionHandler(nil,NSError(domain:"Planets list service is empty", code: 0, userInfo: nil))
            return
        }
    }
    
    /// Fetch tracks from the server and sort by release date.
    func fetchPlanets() {
        
        self.fetchPlanets { resultObject, error in
            
            if let resultListModel = resultObject {
                
                if let results = resultListModel.results {
                    self.processCellModels(results: results)
                    self.planetsArray.value = results
                }
                
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
