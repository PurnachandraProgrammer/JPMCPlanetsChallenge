//
//  ResultListModelTest.swift
//  AppleTrackTestTests
//
//  Created by purnachandra rao obulasetty on 28/11/2021.
//

import XCTest
@testable import JPMCPlanetsChallenge

class PlanetResultModelTest: XCTestCase {
    
    var exampleJSONData: Data!
    var resultListModel: PlanetResults!
    
    override func setUp() {
        let path = Bundle.main.path(forResource: "Planets", ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path))
        let decoder = JSONDecoder()
        resultListModel = try! decoder.decode(PlanetResults.self, from: data)
    }
    
    func testModelPlanetName() throws {
        
        if let resultModel = resultListModel.results?.first {
            XCTAssertEqual(resultModel.name, "Tatooine")
            return
        }
        XCTFail()
    }
}
