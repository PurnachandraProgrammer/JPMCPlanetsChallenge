//  PlanetTableViewCellViewModel.swift
//  JPMCPlanetsChallenge
//  Created by purnachandra rao obulasetty on 11/07/2022.

import Foundation
import UIKit

/// This class is view model for PlanetTableViewCell and responsible for providing data and responsible for download image from the server.
public class PlanetTableViewCellViewModel {
    
    let planetName: String
    
    /// Initialize the view model with the parametrs.
    init(planetName:String) {
        self.planetName = planetName
    }
    
}
