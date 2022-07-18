import XCTest
@testable import JPMCPlanetsChallenge

class PlanetsListViewControllerTest: XCTestCase {

    var storyboard: UIStoryboard!
    var sut: PlanetsListViewController!
    
    var cellID: String!
    var cell: PlanetTableViewCell!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "PlanetsListViewController") as? PlanetsListViewController
        sut.loadViewIfNeeded()
        
        cellID = "PlanetTableViewCell"
        let cellNib = UINib(nibName: "PlanetTableViewCell", bundle: .main)
        sut.planetsListTableView.register(cellNib, forCellReuseIdentifier: "PlanetTableViewCell")
        cell = sut.planetsListTableView.dequeueReusableCell(withIdentifier: "PlanetTableViewCell") as? PlanetTableViewCell
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        storyboard = nil
        sut = nil
        cell = nil
        cellID = nil
    }

    func test_HomeViewController_WhenCreated_HasTableViewProperty() throws {
        // Arrange
        // Act
        let tableView = try XCTUnwrap(sut.planetsListTableView, "TableView is not connected to IBOutlet") // This will Unwrap the optional value and we can add meaningful error
        // Assert
        XCTAssertNotNil(tableView, "TableView is not created")
    }
    
    func test_HomeViewController_WhenCreated_RegisterCustomTableViewCell() {
        
        sut.viewDidLoad()
        XCTAssertNotNil(cell,"TableView doesn't have a cell with PlanetTableViewCell")
        XCTAssertEqual(cell?.reuseIdentifier, "PlanetTableViewCell", "TableView doesn't have a cell with PlanetTableViewCell")
      
    }
    
    func test_HomeViewController_WhenMusicDataAvailable_ShouldUpdateTheMusicCellProperties() throws {
        
        // Arrange
        let testDetails = PlanetTableViewCellViewModel(planetName: "Test")
        // Act
        cell.planetTableViewCellModel = testDetails
        cell.configure()
        
        // Assert
        XCTAssertEqual(cell.planetName.text, "Test")
    }
    
    func test_HomeViewController_WhenMusicCellCreated_ShouldCreateProperties() {
        // Assert
        XCTAssertNotNil(cell.planetName)
    }
    
    func test_HomeViewController_WhenCreated_ShouldBindToTheViewModel() {
        XCTAssertNotNil(sut.planetViewModel)
    }
    
    
    
    

}



