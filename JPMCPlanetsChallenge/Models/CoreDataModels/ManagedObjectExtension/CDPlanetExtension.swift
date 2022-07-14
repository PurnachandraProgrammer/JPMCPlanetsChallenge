//
//  CDPlanetExtension.swift
//  JPMCPlanetsChallenge
//
//  Created by purnachandra rao obulasetty on 11/07/2022.



import Foundation

extension CDPlanet {
    func convertToPlanet() -> Planet {
        
        return Planet(name: self.planetName ?? "")
        /*
        return Planet(climate: "", created: "", diameter: "", edited: "", films: [], gravity: "", name: self.planetName ?? "", orbital_period: "", population: "", residents: [], rotation_period: "", surface_water: "", terrain: "", url: "")
        */
    }
}
