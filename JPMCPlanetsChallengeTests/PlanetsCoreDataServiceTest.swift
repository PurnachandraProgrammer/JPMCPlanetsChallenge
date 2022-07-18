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
        
        _ = coreDataService.insertPlanetRecords(records: resultListModel.results!)
        
        coreDataService.getPlanetRecords { planets in
            
            if planets != nil && planets!.count == 3 {
                
                let firstObject = planets![0]
                let secondObject = planets![1]
                let thirdObject = planets![2]
                
                XCTAssertEqual(firstObject.name, "Tatooine","first record name is not equal to Tatooine")
                XCTAssertEqual(secondObject.name, "Alderaan","first record name is not equal to Alderaan")
                XCTAssertEqual(thirdObject.name, "Yavin IV","third record name is not equal to Yavin IV")

            }
            else {
                XCTFail()
            }
        }
        
    }
}
