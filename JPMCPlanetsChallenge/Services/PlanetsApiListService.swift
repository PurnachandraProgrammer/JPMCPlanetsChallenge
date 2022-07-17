import Foundation

// This class is used to fetch the planets from the server as of now.
final class PlanetsApiListService : PlanetApiResourceService {
    
    var task : URLSessionTask?
    
    // Get the planets from the server
    func getPlanetRecords(completionHandler: @escaping (Array<Planet>?) -> Void) {
        
        self.fetchPlanets { planetResults, error in
            completionHandler(planetResults?.results)
        }
    }
    
    func fetchPlanets(completionHandler: @escaping (PlanetResults?, Error?) -> Void) -> Void {
        self.getTask(with: ApiResource.planetsResource, completionHandler: completionHandler)
    }
    

    // This method is used to perform
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
