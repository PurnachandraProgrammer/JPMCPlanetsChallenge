import XCTest

class JPMCPlanetsChallengeUITests: XCTestCase {
    
    private let app = XCUIApplication()

    override func setUpWithError() throws {
        app.launch()
        continueAfterFailure = false

    }

    override func tearDownWithError() throws {
    }
    
    
    func test_HomeViewController_isTableViewExists() throws {
        
        let tablesQuery = app.tables.matching(identifier: "PlanetsVCTableViewAccessID")
        XCTAssertTrue(tablesQuery.element.exists)
    }
    
    
    func test_HomeViewController_isDetailNavigationBarExists() throws {
        
        let homeVCNavigationBar = app.navigationBars["Planets"]
        XCTAssertTrue(homeVCNavigationBar.exists)

    }
    
    func test_HomeViewController_WhenTableViewPresented_CellsShouldBeEnabledForTap() throws {
        let myTable = app.tables.matching(identifier: "PlanetsVCTableViewAccessID")
            let cell = myTable.cells.element(matching: .cell, identifier: "PlanetCellAccessID_0")
        XCTAssertTrue(cell.isEnabled, "PlanetCells are not enalbed for user interactions")
    }


    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
