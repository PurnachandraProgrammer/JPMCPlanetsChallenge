//
//  PlanetDataService.swift
//  JPMCPlanetsChallenge
//
//  Created by purnachandra rao obulasetty on 11/07/2022.
//

import Foundation
import CoreData


final class PlanetDataService : PlanetCoreDataService {

    /*
    func batchInsertPlanetRecords(records: Array<Planet>) -> Bool {

        PersistentStorage.shared.printDocumentDirectoryPath()

        PersistentStorage.shared.persistentContainer.performBackgroundTask { privateManagedContext in

            // batch inserts
            let request = self.createBatchInsertRequest(records: records)
            do{
                try privateManagedContext.execute(request)
            }catch {
                debugPrint("batch insert error")
            }
        }

        return true

    }*/

    /*
    private func createBatchInsertRequest(records:Array<Planet>) -> NSBatchInsertRequest {

        let totalCount = records.count
        var index = 0

        if #available(iOS 14.0, *) {
            
            let batchInsert = NSBatchInsertRequest(entity: CDPlanet.entity()) { (managedObject: NSManagedObject) -> Bool in
                
                guard index < totalCount else {return true}
                
                if let planet = managedObject as? CDPlanet {
                    let data = records[index]
                    planet.id = UUID()
                    planet.planetName = data.name
                }
                
                index  += 1
                return false
            }
            
            return batchInsert
        } else {
            // Fallback on earlier versions
            
        }
    }*/

    func insertPlanetRecords(records: Array<Planet>) -> Bool {

        debugPrint("PlanetDataService: Insert record operation is starting")

        PersistentStorage.shared.persistentContainer.performBackgroundTask { privateManagedContext in
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


    func getPlanetRecords(completionHandler: @escaping (Array<Planet>?) -> Void) {

        //PersistentStorage.shared.printDocumentDirectoryPath()

        let result = PersistentStorage.shared.fetchManagedObject(managedObject: CDPlanet.self)
            var planets : Array<Planet> = []
            result?.forEach({ (cdPlanet) in
                planets.append(cdPlanet.convertToPlanet())
            })

            completionHandler(planets)

    }
}
