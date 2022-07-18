import XCTest
@testable import JPMCPlanetsChallenge


class PlanetsCoreDataServiceTest: XCTestCase {
    
    var resultListModel: PlanetResults!
    var coreDataService = PlanetDataService()
    
    override func setUp() {
        
        guard let filePath = Bundle(for: PlanetsListViewModelTest.self).url(forResource: "Planets", withExtension: "json"),let data = try? Data(contentsOf: filePath) else {
            return
        }
        let decoder = JSONDecoder()
        resultListModel = try? decoder.decode(PlanetResults.self, from: data)

    }
    
    func testResultModelPlanetName() {
        
        let expectation = XCTestExpectation(description: "planets core data fetch")
        coreDataService.insertPlanetRecords(records: resultListModel.results!) { error in

            guard let _ = error else {
                XCTFail("insert planet records failed")
                return
            }
            self.coreDataService.getPlanetRecords { planets in
                
                if planets != nil && planets!.count > 0 {
                    expectation.fulfill()
                }
                else {
                }
            }

        }
    }
}
