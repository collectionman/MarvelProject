//
//  MarvelResponse.swift
//  MarvelDev
//
//  Created by Julian Llorensi on 25/04/2019.
//  Copyright © 2019 globant. All rights reserved.
//

import Foundation

struct MarvelResponse<T: Codable>: Codable {
    var data: MarvelData<T>
}

