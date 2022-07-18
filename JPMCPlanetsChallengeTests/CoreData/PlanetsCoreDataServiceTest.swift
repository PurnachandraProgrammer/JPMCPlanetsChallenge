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
    
    func testCoreDataRecordsInsertion() {
        
        let expectation = XCTestExpectation(description: "planets core data fetch")
        coreDataService.insertPlanetRecords(records: resultListModel.results!) { error in
            
            if error == nil {
                self.coreDataService.getPlanetRecords { planets in
                    
                    if planets != nil && planets!.count > 0 {
                        expectation.fulfill()
                    }
                    else {
                        XCTFail("insert planet records failed")
                    }
                }
            }
            else {
                XCTFail("insert planet records failed")
            }
            
        }
        wait(for: [expectation], timeout: 10)
    }
}
