//
//  PlanetsDetailViewController.swift
//  JPMCPlanetsChallenge
//
//  Created by purnachandra rao obulasetty on 27/07/2022.
//

import UIKit

class PlanetsDetailViewController: UIViewController {

    @IBOutlet weak var planetNameLabel: UILabel!
    @IBOutlet weak var planetClimateLabel: UILabel!
    @IBOutlet weak var planetTerrainLabel: UILabel!
    
    var planetsDetailViewModel : PlanetDetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func configure() {
        
        guard let planet = self.planetsDetailViewModel?.getPlanet() else {
            return
        }
        
        self.planetNameLabel.text = planet.name
        self.planetTerrainLabel.text = planet.terrain
        self.planetClimateLabel.text = planet.climate
        
    }
}
