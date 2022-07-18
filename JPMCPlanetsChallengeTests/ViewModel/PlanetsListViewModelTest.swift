import XCTest
import Foundation
@testable import JPMCPlanetsChallenge

class PlanetsListViewModelTest: XCTestCase {
    
    var planetViewModel : PlanetsListViewModel!
    fileprivate var planetTestService : MockPlanetsListService!
    
    override func setUp() {
        super.setUp()
        
        // Create View model with the help mock API service and PlanetDataService
        self.planetViewModel = PlanetsListViewModel(planetsListService: MockPlanetsListService(), coreDataService: PlanetDataService())
    }
    
    override func tearDown() {
        self.planetViewModel = nil
        super.tearDown()
    }
    
    func testFetchPlanets() {
        
        let expectation = XCTestExpectation(description: "planets fetch")
        
        // Fetch planets using View Model.
        planetViewModel.fetchPlanets(completionHandler: { planets, error in
            
            // If planets count greather than zero, it is success
            if planets != nil && planets!.count > 0 {
                expectation.fulfill()
            }
            // Failure in case of empty list
            else {
                XCTAssert(false, "planets count should be greater than zero")
            }
        })
        wait(for: [expectation], timeout: 5.0)
    }
}

// Mock API service, to get the planets from JSON.
fileprivate class MockPlanetsListService : PlanetBaseService {
    
    func getPlanetRecords(completionHandler: @escaping (Array<Planet>?) -> Void) {
        
        guard let filePath = Bundle(for: PlanetsListViewModelTest.self).url(forResource: "Planets", withExtension: "json"),
              let data = try? Data(contentsOf: filePath) else {
                  return completionHandler(nil)
              }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let resultModel = try? decoder.decode(PlanetResults.self, from: data)
        completionHandler(resultModel?.results)
        
    }
    
}
