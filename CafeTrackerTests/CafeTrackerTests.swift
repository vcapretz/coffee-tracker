//
//  CafeTrackerTests.swift
//  CafeTrackerTests
//
//  Created by Vitor Capretz on 24/01/18.
//  Copyright © 2018 Vitor Capretz. All rights reserved.
//

import XCTest
@testable import CafeTracker

class CafeTrackerTests: XCTestCase {
    //MARK: Coffee Class tests
    
    func testCoffeeInitializationSucceeds() {
        // Zero rating
        let zeroRatingCoffee = Coffee.init(name: "Zero", photo: nil, rating: 0)
        XCTAssertNotNil(zeroRatingCoffee)
        
        // Highest positive rating
        let positiveRatingCoffee = Coffee.init(name: "Positive", photo: nil, rating: 5)
        XCTAssertNotNil(positiveRatingCoffee)
    }
    
    func testCoffeeInitializationFails() {
        let negativeRating = Coffee.init(name: "Negative", photo: nil, rating: -42)
        XCTAssertNil(negativeRating)
        
        let noNameRating = Coffee.init(name: "", photo: nil, rating: 18)
        XCTAssertNil(noNameRating)
        
        let largeRatingCoffee = Coffee.init(name: "Large", photo: nil, rating: 6)
        XCTAssertNil(largeRatingCoffee)
    }
}
