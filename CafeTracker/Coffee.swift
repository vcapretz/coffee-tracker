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
        if name.isEmpty || rating < 0 {
            return nil
        }

        self.name = name
        self.photo = photo
        self.rating = rating
    }
}
