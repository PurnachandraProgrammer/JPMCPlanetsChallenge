//
//  PlanetsListViewController.swift
//  JPMCPlanetsChallenge
//
//  Created by purnachandra rao obulasetty on 11/07/2022.
//

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
            
            /// Register TrackTableViewCell  nib to use in the tableview. By creating separate nib file, it can be re-used.
            let cellNib = UINib(nibName: "PlanetTableViewCell", bundle: .main)
            planetsListTableView.register(cellNib, forCellReuseIdentifier: "PlanetTableViewCell")
        }
    }
    
    /// The PlanetsListViewModel is View model of PlanetsListViewController
    private let planetViewModel = PlanetsListViewModel(planetsListService: PlanetsApiListService(),coreDataService:PlanetDataService())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTitle()
        initBindingAndFetchPlanets()
    }
    
    private func initTitle() {
        self.title = AppConstants.rootViewControllerTitle
    }
    
    /// Initialise the binding and fetching tracks from the server
    ///
    /// Binding initialisation and calls to fetch the tracks from server with help of TrackViewModel
    ///
    private func initBindingAndFetchPlanets() {
        
        /// Observe the tracksArray changes and load tableview
        self.planetViewModel.planetsArray.bind { _ in
            
            /// Observe the tracksArray changes and reload the tableview to show the tracks list
            /// Stop loading indicator after  tracksArray changes are observed.
            DispatchQueue.main.async {
                self.planetsListTableView.reloadData()
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
            }
        }
        
        /// Observe the apiFetchError and show alert with the error
        self.planetViewModel.apiFetchError.bind { error in
            
            var apiError = error
            /// Show error alert in case error occured.
            if apiError == nil {
                apiError = NSError(domain: "planets list API fetch error", code: 0, userInfo: nil)
            }
            
            let alert = UIAlertController(title: "Error", message: apiError?.localizedDescription, preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(alertAction)
            
            DispatchQueue.main.async {
                
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
                self.present(alert, animated: true, completion: nil)
            }
            return
            
        }
        
        
        /// Showing the loading indicator before calling fetchTracks. Stop This indicator  after tracks fetching completed or in case of error.
        
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
        
        /// Call the fetchTracks function to fetch the tracks
        planetViewModel.fetchPlanets()
        
    }
}

/// UITableViewDelegate and UITableViewDataSource methods implementation
extension PlanetsListViewController : UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return planetViewModel.getNumberOfPlanets()
    }
    
    /// 1. Create PlanetTableViewCell
    /// 2. Get the cell view model and assign it to PlanetTableViewCell property
    /// 3. Configure table view cell UI with the help of PlanetTableViewCell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let tableViewCell = self.planetsListTableView.dequeueReusableCell(withIdentifier: "PlanetTableViewCell") as! PlanetTableViewCell
        tableViewCell.planetTableViewCellModel = planetViewModel.getCellViewModel(at: indexPath)
        tableViewCell.configure()
        return tableViewCell
    }
    
    
    /// This delegate is to handle tableview row selection
    /// 1. Create the PlanetsDetailsViewController
    /// 2. Create PlanetDetailViewModel  object by passing track object.
    /// 3. Configure table view cell UI with the help of PlanetViewCellModel
    /*
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
     let detailViewController = self.storyboard?.instantiateViewController(withIdentifier: "PlanetsDetailsViewController") as! PlanetDetailsViewController
     detailViewController.planetDetailViewModel = PlanetDetailViewModel(selectedPlanetObject: planetViewModel.planetsArray.value[indexPath.row])
     self.navigationController?.pushViewController(detailViewController, animated: true)
     tableView.deselectRow(at: indexPath, animated: true)
     
     }*/
}

