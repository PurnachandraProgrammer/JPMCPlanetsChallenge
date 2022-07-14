//
//  JPMCPlanetsChallengeTests.swift
//  JPMCPlanetsChallenge
//
//  Created by purnachandra rao obulasetty on 28/11/2021.
//

import XCTest
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
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}

fileprivate class MockPlanetsListService : PlanetBaseService {
    
    
    func getPlanetRecords(completionHandler: @escaping (Array<Planet>?) -> Void) {

        let path = Bundle.main.path(forResource: "Planets", ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path))
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let resultModel = try? decoder.decode(PlanetResults.self, from: data)
        completionHandler(resultModel?.results)

    }
    

}
