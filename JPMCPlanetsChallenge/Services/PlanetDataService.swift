//
//  PlanetDataService.swift
//  JPMCPlanetsChallenge
//
//  Created by purnachandra rao obulasetty on 11/07/2022.
//

import Foundation
import CoreData


final class PlanetDataService : PlanetCoreDataService {

    // This method is used Insert the records in core data
    
    func insertPlanetRecords(records:Array<Planet>,completionHandler: @escaping (_ error:Error?) -> Void) {
        
        debugPrint("PlanetDataService: Insert record operation is starting")
        
        CoreDataHelper.shared.persistentContainer.performBackgroundTask { privateManagedContext in
            
            //Create CDPanet with private context
            records.forEach { planetRecord in
                let cdPlanet = CDPlanet(context: privateManagedContext)
                cdPlanet.id = UUID()
                cdPlanet.planetName = planetRecord.name
            }
            
            // save the changes.
            if(privateManagedContext.hasChanges){
                
                do {
                    try privateManagedContext.save()
                }
                catch {
                    completionHandler(error)
                }
            }
        }
    }
    
    // Get records(CDPlanet) from the core data and convert to Planet
    func getPlanetRecords(completionHandler: @escaping (Array<Planet>?) -> Void) {
        
        let result = CoreDataHelper.shared.fetchManagedObject(managedObject: CDPlanet.self)
        var planets : Array<Planet> = []
        result?.forEach({ (cdPlanet) in
            planets.append(cdPlanet.convertToPlanet())
        })
        
        completionHandler(planets)
        
    }
}
