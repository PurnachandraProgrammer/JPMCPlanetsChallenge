//
//  PlanetDataService.swift
//  JPMCPlanetsChallenge
//
//  Created by purnachandra rao obulasetty on 11/07/2022.
//

import Foundation
import CoreData


final class PlanetDataService : PlanetCoreDataService {
    
    func insertPlanetRecords(records: Array<Planet>) -> Bool {
        
        debugPrint("PlanetDataService: Insert record operation is starting")
        
        CoreDataHelper.shared.persistentContainer.performBackgroundTask { privateManagedContext in
            
            //insert code
            records.forEach { planetRecord in
                let cdPlanet = CDPlanet(context: privateManagedContext)
                cdPlanet.id = UUID()
                cdPlanet.planetName = planetRecord.name
            }
            
            if(privateManagedContext.hasChanges){
                try? privateManagedContext.save()
                debugPrint("PlanetDataService: Insert record operation is completed")
                
            }
        }
        
        return true
    }
    
    
    func deletePlanetRecords() {
        
        debugPrint("PlanetDataService: Insert record operation is starting")
        
        let result = CoreDataHelper.shared.fetchManagedObject(managedObject: CDPlanet.self)
        
        CoreDataHelper.shared.persistentContainer.performBackgroundTask { privateManagedContext in
            
            //insert code
            result?.forEach { cdPlanet in
                privateManagedContext.delete(cdPlanet)
            }
            
            if(privateManagedContext.hasChanges){
                try? privateManagedContext.save()
                debugPrint("PlanetDataService: Insert record operation is completed")
                
            }
        }
        
    }
    
    func getPlanetRecords(completionHandler: @escaping (Array<Planet>?) -> Void) {
        
        let result = CoreDataHelper.shared.fetchManagedObject(managedObject: CDPlanet.self)
        var planets : Array<Planet> = []
        result?.forEach({ (cdPlanet) in
            planets.append(cdPlanet.convertToPlanet())
        })
        
        completionHandler(planets)
        
    }
}
