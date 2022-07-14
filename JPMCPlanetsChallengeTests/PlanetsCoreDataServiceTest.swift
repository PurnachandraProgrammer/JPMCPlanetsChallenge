//
//  ResultListModelTest.swift
//  AppleTrackTestTests
//
//  Created by purnachandra rao obulasetty on 28/11/2021.
//

import XCTest
@testable import JPMCPlanetsChallenge


class PlanetsCoreDataServiceTest: XCTestCase {
    
    var resultListModel: PlanetResults!
    var coreDataService = PlanetDataService()
    
    override func setUp() {
        let path = Bundle.main.path(forResource: "Planets", ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path))
        let decoder = JSONDecoder()
        resultListModel = try! decoder.decode(PlanetResults.self, from: data)
    }
    
    func testResultModelPlanetName() throws {
        
        _ = coreDataService.batchInsertPlanetRecords(records: resultListModel.results!)
        
        coreDataService.getPlanetRecords { planets in
            
            if planets != nil && planets!.count > 0 {
            }
            else {
                XCTFail()
            }
        }
        
    }
}
