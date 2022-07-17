//
//  PlanetModel.swift
//  Created by purnachandra rao obulasetty on 11/07/2022.
//  Copyright © 2022 purnachandra rao obulasetty. All rights reserved.

import Foundation

// MARK: - PlanetResults
 struct PlanetResults:Codable {
    
    let count:Int
    let next:String
    let previous:String?
    let results:[Planet]?
}

// MARK: - Planet

/*
struct Planet:Codable {
    let climate:String
    let created:String
    let diameter:String
    let edited:String
    let films:[String]
    let gravity:String;
    let name:String;
    let orbital_period:String;
    let population:String
    let residents:[String]
    let rotation_period:String
    let surface_water:String
    let terrain:String;
    let url:String;
    
}*/

struct Planet:Codable {
    let name:String;
}


