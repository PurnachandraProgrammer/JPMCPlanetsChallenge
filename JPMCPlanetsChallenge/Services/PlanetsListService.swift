//
//  TracksListService.swift
//  AppleTrackTest
//
//  Created by purnachandra rao obulasetty on 29/11/2021.
//

import Foundation

protocol PlanetsListServiceProtocol {
    
    func fetchPlanets(completionHandler: @escaping (PlanetResults?,Error?) -> Void) -> Void;
    
}

final class PlanetsListService : PlanetsListServiceProtocol {
    
    let endpoint = "https://swapi.dev/api/planets/"
    var task : URLSessionTask?
    
    func fetchPlanets(completionHandler: @escaping (PlanetResults?, Error?) -> Void) -> Void {
        let url = URL(string: endpoint)
        self.getTask(with: url!, completionHandler: completionHandler)
    }
    
    fileprivate func getTask<T: Codable>(with url: URL, completionHandler: @escaping (T?, Error?) -> Void) -> Void {
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(nil, error)
                return
            }
            
            do {
                let decoded = try JSONDecoder().decode(T.self, from: data)
                completionHandler(decoded, nil)
                print(decoded)
            } catch {
                print(error)
                /// Handled catch
                completionHandler(nil, error)
            }
            
        }
        task.resume()
    }
    
    func cancelFetchPlanets() {
        
        if let task = task {
            task.cancel()
        }
        task = nil
    }
}
