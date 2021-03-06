import UIKit

class PlanetTableViewCell: UITableViewCell {
    
    @IBOutlet weak var planetName: UILabel!
    public var planetTableViewCellModel : PlanetTableViewCellViewModel?
    
    func configure() {
        
        // Check the nil value of resultModel
        guard let planetCellModel = planetTableViewCellModel else {
            return
        }
        
        // Assign values to table view cell
        planetName?.text = planetCellModel.planetName
    }
}
