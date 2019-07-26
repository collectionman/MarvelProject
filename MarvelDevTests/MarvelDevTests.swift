//
//  MarvelDevTests.swift
//  MarvelDevTests
//
//  Created by Julian Llorensi on 23/04/2019.
//  Copyright © 2019 globant. All rights reserved.
//

import XCTest
@testable import MarvelDev

class MarvelDevTests: XCTestCase {
    var hero = Hero()
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        hero.id = 0
        hero.name = "Spiderman"
        hero.description = "bla bla bla"
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        hero = Hero()
    }

    func testGetHeroName() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertTrue( hero.name == "Spiderman" )
    }
    
    func testAPIManagerConnection() {
        
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
