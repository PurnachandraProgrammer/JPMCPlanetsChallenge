import XCTest
@testable import JPMCPlanetsChallenge

class PlanetResultModelTest: XCTestCase {
    
    var exampleJSONData: Data!
    var resultListModel: PlanetResults!
    
    override func setUp() {
        
        guard let filePath = Bundle(for: PlanetsListViewModelTest.self).url(forResource: "Planets", withExtension: "json"),let data = try? Data(contentsOf: filePath) else {
            return
        }
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
