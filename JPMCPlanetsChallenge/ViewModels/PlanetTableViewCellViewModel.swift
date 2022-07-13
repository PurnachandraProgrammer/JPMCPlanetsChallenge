//
//  TrackTableViewCellViewModel.swift
//  AppleTrackTest
//
//  Created by purnachandra rao obulasetty on 28/11/2021.
//

import Foundation
import UIKit

/// This class is view model for TrackTableViewCell and responsible for providing data and responsible for download image from the server.
public class PlanetTableViewCellViewModel {
    
    let planetName: String
    
    /// Initialize the view model with the parametrs.
    init(planetName:String) {
        self.planetName = planetName
    }
    
}
