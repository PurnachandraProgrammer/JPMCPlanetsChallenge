//
//  PlanetSerivceProtocols.swift
//  JPMCPlanetsChallenge
//
//  Created by purnachandra rao obulasetty on 11/07/2022.
//

import Foundation

protocol PlanetBaseService {
    func getPlanetRecords(completionHandler:@escaping(_ result: Array<Planet>?)->Void)
}

protocol PlanetCoreDataService : PlanetBaseService {
    func insertPlanetRecords(records:Array<Planet>) -> Bool
    func batchInsertPlanetRecords(records:Array<Planet>) -> Bool
}

protocol PlanetApiResourceService : PlanetBaseService {

}
