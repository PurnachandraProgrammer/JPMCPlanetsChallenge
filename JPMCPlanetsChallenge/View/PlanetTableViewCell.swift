//
//  TrackTableViewCell.swift
//  AppleTrackTest
//
//  Created by purnachandra rao obulasetty on 27/11/2021.
//

import UIKit

class PlanetTableViewCell: UITableViewCell {
    
    @IBOutlet weak var planetName: UILabel!
    var planetTableViewCellModel : PlanetTableViewCellViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure() {
        
        // Check the nil value of resultModel
        guard let trackCellModel = planetTableViewCellModel else {
            return
        }
        
        // Assign values from result Model
        planetName?.text = trackCellModel.planetName
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
