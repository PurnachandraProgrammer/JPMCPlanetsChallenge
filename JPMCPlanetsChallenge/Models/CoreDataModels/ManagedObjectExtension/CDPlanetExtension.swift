//
//  CDPlanetExtension.swift
//  JPMCPlanetsChallenge
//
//  Created by purnachandra rao obulasetty on 11/07/2022.



import Foundation

extension CDPlanet {
    
    // Convert the Core data record to Planet object
    func convertToPlanet() -> Planet {
        return Planet(name: self.planetName ?? "")
    }
}
