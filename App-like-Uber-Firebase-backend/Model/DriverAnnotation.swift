//
//  DriverAnnotation.swift
//  App-like-Uber-Firebase-backend
//
//  Created by Tazo Gigitashvili on 04.05.23.
//

import MapKit

class DriverAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var uid: String
    
    init(uid: String, coordinate: CLLocationCoordinate2D) {
        self.uid = uid
        self.coordinate = coordinate
    }
}
