import XCTest
import Foundation
@testable import JPMCPlanetsChallenge

class PlanetsListViewModelTest: XCTestCase {
    
    var planetViewModel : PlanetsListViewModel!
    fileprivate var planetTestService : MockPlanetsListService!
    
    override func setUp() {
        super.setUp()
        self.planetViewModel = PlanetsListViewModel(planetsListService: MockPlanetsListService(), coreDataService: PlanetDataService())
    }
    
    override func tearDown() {
        self.planetViewModel = nil
        super.tearDown()
    }
    
    func testFetchPlanets() {
        
        let expectation = XCTestExpectation(description: "planets fetch")
        
        planetViewModel.apiFetchError.bind { error in
            
            if error != nil {
                XCTAssert(false, "ViewModel should not be able to fetch without service")
            }
        }
        
        planetViewModel.planetsArray.bind { _ in
            expectation.fulfill()
        }
        planetViewModel.fetchPlanets(completionHandler: { planets, error in
            
            if planets != nil && planets!.count > 0 {
                expectation.fulfill()
            }
            else {
                XCTAssert(false, "planets count should be greater than zero")
            }
        })
        wait(for: [expectation], timeout: 5.0)
    }
    
    
    override func setUpWithError() throws {
    }
    
    override func tearDownWithError() throws {
    }
    
    func testExample() throws {
    }
    
    func testPerformanceExample() throws {
        measure {
        }
    }
    
}

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
