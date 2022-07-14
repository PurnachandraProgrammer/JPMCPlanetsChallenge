//
//  AppConstants.swift
//  JPMCPlanetsChallenge
//
//  Created by purnachandra rao obulasetty on 11/07/2022.
//


import Foundation

struct AppConstants {
    static let rootViewControllerTitle = "Planets"
}

struct ApiResource {
    static let planetsResource : URL = URL(string: "https://swapi.dev/api/planets/")!
}
