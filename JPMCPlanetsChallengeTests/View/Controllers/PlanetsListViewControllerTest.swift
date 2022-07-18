import XCTest
@testable import JPMCPlanetsChallenge

class PlanetsListViewControllerTest: XCTestCase {

    var storyboard: UIStoryboard!
    var sut: PlanetsListViewController!
    
    var cellID: String!
    var cell: PlanetTableViewCell!
    
    override func setUpWithError() throws {
        
        // Create story board
        storyboard = UIStoryboard(name: "Main", bundle: nil)
        // Instantiate PlanetsListViewController
        sut = storyboard.instantiateViewController(withIdentifier: "PlanetsListViewController") as? PlanetsListViewController
        sut.loadViewIfNeeded()
        
        cellID = "PlanetTableViewCell"
        
        // Create nib file
        let cellNib = UINib(nibName: "PlanetTableViewCell", bundle: .main)
        
        // Register nib with the tableview
        sut.planetsListTableView.register(cellNib, forCellReuseIdentifier: "PlanetTableViewCell")
        
        // Create cell
        cell = sut.planetsListTableView.dequeueReusableCell(withIdentifier: "PlanetTableViewCell") as? PlanetTableViewCell
    }

    override func tearDownWithError() throws {
        storyboard = nil
        sut = nil
        cell = nil
        cellID = nil
    }

    func test_HomeViewController_WhenCreated_HasTableViewProperty() throws {
        let tableView = try XCTUnwrap(sut.planetsListTableView, "TableView is not connected to IBOutlet")
        
        // Check if tableView is created
        XCTAssertNotNil(tableView, "TableView is not created")
    }
    
    func test_HomeViewController_WhenCreated_RegisterCustomTableViewCell() {
        
        sut.viewDidLoad()
        XCTAssertNotNil(cell,"TableView doesn't have a cell with PlanetTableViewCell")
        XCTAssertEqual(cell?.reuseIdentifier, "PlanetTableViewCell", "TableView doesn't have a cell with PlanetTableViewCell")
      
    }
    
    func test_HomeViewController_WhenMusicDataAvailable_ShouldUpdateTheMusicCellProperties() throws {
        
        // Create TableViewCellViewModel
        let testDetails = PlanetTableViewCellViewModel(planetName: "Test")
        cell.planetTableViewCellModel = testDetails
        cell.configure()
        
        // Compare planetName label text with "Test"
        XCTAssertEqual(cell.planetName.text, "Test")
    }
    
    func test_HomeViewController_WhenMusicCellCreated_ShouldCreateProperties() {
        // Check the not nil value of planetName
        XCTAssertNotNil(cell.planetName)
    }
    
    func test_HomeViewController_WhenCreated_ShouldBindToTheViewModel() {
        // Check the not nil value of planetViewModel
        XCTAssertNotNil(sut.planetViewModel)
    }
    
    
    
    

}



