//
//  MarvelData.swift
//  MarvelDev
//
//  Created by Julian Llorensi on 25/04/2019.
//  Copyright © 2019 globant. All rights reserved.
//

import Foundation

struct MarvelData<T: Codable>: Codable {
    var results: [T?]?
}
