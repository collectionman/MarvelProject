//
//  Thumbnail.swift
//  MarvelDev
//
//  Created by Julian Llorensi on 25/04/2019.
//  Copyright © 2019 globant. All rights reserved.
//

import Foundation

struct Thumbnail: Codable {
    var path: String?
    var imageExtension: String?
    
    func asString() -> String {
        return "\(String(describing: path)).\(String(describing: imageExtension))"
    }
    
    enum CodingKeys: String, CodingKey {
        case path
        case imageExtension = "extension"
    }
}
