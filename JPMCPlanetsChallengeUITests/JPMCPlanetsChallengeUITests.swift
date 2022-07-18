import XCTest

class JPMCPlanetsChallengeUITests: XCTestCase {
    
    private let app = XCUIApplication()


    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        app.launch()
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
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
           // cell.tap()
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
