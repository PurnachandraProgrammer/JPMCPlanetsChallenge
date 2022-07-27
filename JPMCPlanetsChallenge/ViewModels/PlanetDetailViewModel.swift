//
//  PlanetDetailViewModel.swift
//  JPMCPlanetsChallenge
//
//  Created by purnachandra rao obulasetty on 27/07/2022.
//

import Foundation

public class PlanetDetailViewModel {
    
    let planet:Planet
    
    init(planet:Planet) {
        self.planet = planet
    }
    
    func getPlanet() -> Planet {
        return planet
    }
    
}
