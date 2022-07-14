//
//  CDPlanetExtension.swift
//  JPMCPlanetsChallenge
//
//  Created by purnachandra rao obulasetty on 11/07/2022.



import Foundation

extension CDPlanet {
    func convertToPlanet() -> Planet {
        return Planet(name: self.planetName ?? "")
    }
}
