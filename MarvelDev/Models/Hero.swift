//
//  Hero.swift
//  MarvelDev
//
//  Created by Julian Llorensi on 23/04/2019.
//  Copyright © 2019 globant. All rights reserved.
//

import Foundation

struct Hero: Codable {
    var id : Int?
    var name: String?
    var description: String?
    var thumbnail: Thumbnail?
    // var comics: [ Comic ]
    
    func getName() -> String? {
        return name!
    }
}


