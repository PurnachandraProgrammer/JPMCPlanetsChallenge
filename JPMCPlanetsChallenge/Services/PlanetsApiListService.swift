//
//  PlanetsApiListService.swift
//  JPMCPlanetsChallenge
//
//  Created by purnachandra rao obulasetty on 11/07/2022.
//


import Foundation

final class PlanetsApiListService : PlanetApiResourceService {
    
    var task : URLSessionTask?
    
    func getPlanetRecords(completionHandler: @escaping (Array<Planet>?) -> Void) {
        
        self.fetchPlanets { planetResults, error in
            completionHandler(planetResults?.results)
        }
    }
    
    func fetchPlanets(completionHandler: @escaping (PlanetResults?, Error?) -> Void) -> Void {
        self.getTask(with: ApiResource.planetsResource, completionHandler: completionHandler)
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
