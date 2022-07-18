import Foundation
import UIKit

struct AppConstants {
    static let rootViewControllerTitle = "Planets"
    static let orangeColor = UIColor(red: 0.851, green: 0.498, blue: 0.008, alpha: 1)
}

struct ApiResource {
    static let planetsResource : URL = URL(string: "https://swapi.dev/api/planets/")!
}
