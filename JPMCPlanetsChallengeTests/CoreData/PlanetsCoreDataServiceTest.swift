import XCTest
@testable import JPMCPlanetsChallenge


class PlanetsCoreDataServiceTest: XCTestCase {
    
    var resultListModel: PlanetResults!
    var coreDataService = PlanetDataService()
    
    override func setUp() {
        
        // Get the Planets.json file path
        guard let filePath = Bundle(for: PlanetsListViewModelTest.self).url(forResource: "Planets", withExtension: "json"),let data = try? Data(contentsOf: filePath) else {
            return
        }
        
        let decoder = JSONDecoder()
        
        // Using JSONDecoder convert date to resultsListModel.
        resultListModel = try? decoder.decode(PlanetResults.self, from: data)
        
    }
    
    func testCoreDataRecordsInsertion() {
        
        let expectation = XCTestExpectation(description: "planets core data fetch")
        
        //Insert planet records using coreDataService.
        coreDataService.insertPlanetRecords(records: resultListModel.results!) { error in
            
            // Insertion success with out an error
            if error == nil {
                
                // get planets records from core data
                self.coreDataService.getPlanetRecords { planets in
                    
                    // If planet records are available, the test case is success
                    if planets != nil && planets!.count > 0 {
                        expectation.fulfill()
                    }
                    // insertion records failed.
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
