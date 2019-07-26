//
//  MarvelAnnotation.swift
//  MarvelDev
//
//  Created by Julian Llorensi on 24/04/2019.
//  Copyright © 2019 globant. All rights reserved.
//

import UIKit
import MapKit

class MarvelAnnotation: NSObject, MKAnnotation {
    let title: String?
    let subtitle: String?
    let coordinate: CLLocationCoordinate2D
    
    init( title: String?, subtitle: String?, coordinate: CLLocationCoordinate2D ) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
        
        super.init()
    }
}
