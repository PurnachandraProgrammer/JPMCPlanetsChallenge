import UIKit

/// This project uses MVVM architecutre pattern.
/// The MVVM has Model, View and View Model.

/// This class shows the list of planets by using tableview and shows the error alert in case of error.
class PlanetsListViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var planetsListTableView: UITableView! {
        
        didSet {
            
            /// Set delegate and data source
            planetsListTableView.delegate = self
            planetsListTableView.dataSource = self
            planetsListTableView.tableFooterView = .init()
            planetsListTableView.accessibilityIdentifier = "PlanetsVCTableViewAccessID" // For UI Test
            
            /// Register PlanetTableViewCell  nib to use in the tableview. By creating separate nib file, it can be re-used.
            let cellNib = UINib(nibName: "PlanetTableViewCell", bundle: .main)
            planetsListTableView.register(cellNib, forCellReuseIdentifier: "PlanetTableViewCell")
        }
    }
    
    /// The PlanetsListViewModel is View model of PlanetsListViewController
    let planetViewModel = PlanetsListViewModel(planetsListService: PlanetsApiListService(),coreDataService:PlanetDataService())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTitle()
        initBindingAndFetchPlanets()
    }
    
    private func initTitle() {
        self.title = AppConstants.rootViewControllerTitle
        navigationController?.navigationBar.tintColor = AppConstants.orangeColor
    }
    
    /// Initialise the binding and fetching planets from the server
    /// Binding initialisation and calls to fetch the planets from server with help of PlanetsListViewModel
    private func initBindingAndFetchPlanets() {
        
        /// Observe the planetsArray changes and load tableview
        self.planetViewModel.planetsArray.bind { planets in
            
            /// Observe the planetsArray changes and reload the tableview to show the planets list
            /// Stop loading indicator after  planetsArray changes are observed.
            DispatchQueue.main.async {
                self.planetsListTableView.reloadData()
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
            }
            return
        }
        
        /// Observe the apiFetchError and show alert with the error
        self.planetViewModel.apiFetchError.bind { error in
            /// Show error alert in case error occured.
            if let error = error {
                
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                alert.addAction(alertAction)
                
                // Show the error in the main queue
                DispatchQueue.main.async {
                    
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.isHidden = true
                    self.present(alert, animated: true, completion: nil)
                }
                
            }
        }
        
        /// Showing the loading indicator before calling fetchPlanets. Stop This indicator after planets fetching completed or in case of error.
        DispatchQueue.main.async {
            self.activityIndicator.isHidden = false
            self.activityIndicator.startAnimating()
        }
        
        /// Call the fetchPlanets function to fetch the planets
        planetViewModel.fetchPlanets()
    }
}

/// UITableViewDelegate and UITableViewDataSource methods implementation
extension PlanetsListViewController : UITableViewDelegate,UITableViewDataSource {
    
    // Get the number of planets by using view model.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return planetViewModel.getNumberOfPlanets()
    }
    
    /// 1. Create PlanetTableViewCell
    /// 2. Get the cell view model and assign it to PlanetTableViewCell property
    /// 3. Configure table view cell UI with the help of PlanetTableViewCell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let tableViewCell = self.planetsListTableView.dequeueReusableCell(withIdentifier: "PlanetTableViewCell") as! PlanetTableViewCell
        tableViewCell.planetTableViewCellModel = planetViewModel.getCellViewModel(at: indexPath)
        tableViewCell.accessibilityIdentifier = "PlanetCellAccessID_\(indexPath.row)" // For UI Test
        tableViewCell.configure()
        return tableViewCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        self.tabBarController?.selectedIndex = 1

        guard let tabBarViewControllers = self.tabBarController?.viewControllers, tabBarViewControllers.count > 0 else  {
            return
        }
        
        let detailViewController = tabBarViewControllers[1] as! PlanetsDetailViewController
        detailViewController.planetsDetailViewModel = PlanetDetailViewModel(planet: self.planetViewModel.planetsArray.value[indexPath.row])
        detailViewController.configure()
        

    }
}

