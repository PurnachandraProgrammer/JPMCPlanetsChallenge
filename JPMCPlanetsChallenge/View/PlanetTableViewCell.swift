//  JPMCPlanetsChallenge
//  Created by purnachandra rao obulasetty on 11/07/2022.

import UIKit

class PlanetTableViewCell: UITableViewCell {
    
    @IBOutlet weak var planetName: UILabel!
    var planetTableViewCellModel : PlanetTableViewCellViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure() {
        
        // Check the nil value of resultModel
        guard let planetCellModel = planetTableViewCellModel else {
            return
        }
        
        // Assign values from result Model
        planetName?.text = planetCellModel.planetName
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
