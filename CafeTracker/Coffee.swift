//
//  Coffee.swift
//  CafeTracker
//
//  Created by Vitor Capretz on 04/02/18.
//  Copyright © 2018 Vitor Capretz. All rights reserved.
//

import UIKit

class Coffee {
    var name: String
    var photo: UIImage?
    var rating: Int
    
    //MARK: Initialization
    init?(name: String, photo: UIImage?, rating: Int) {
        guard !name.isEmpty else {
            return nil
        }
        
        guard rating >= 0 && rating <= 5 else {
            return nil
        }

        self.name = name
        self.photo = photo
        self.rating = rating
    }
}
