//
//  CoffeeTableViewCell.swift
//  CafeTracker
//
//  Created by Vitor Capretz on 05/02/18.
//  Copyright © 2018 Vitor Capretz. All rights reserved.
//

import UIKit

class CoffeeTableViewCell: UITableViewCell {
    //MARK: Properties
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
