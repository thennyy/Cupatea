//
//  PlaceMarker.swift
//  Cupatea
//
//  Created by Thenny Chhorn on 10/28/22.
//

import UIKit
import CoreLocation

struct PlaceMarker {
    
    let name: String
    let streetName: String
    let streetNumber: String
    let city: String
    let state: String
    let zipCode: String
    let country: String
    
    var formattedAddress: String {
        return "\(city), \(state) \(zipCode), \(country)"
    }
    var shortFormattedAddress: String {
        return "\(city), \(state)"
    }
    
    init(with placemark: CLPlacemark) {
        self.name = placemark.name ?? ""
        self.streetName = placemark.thoroughfare ?? ""
        self.streetNumber = placemark.subThoroughfare ?? ""
        self.city = placemark.locality ?? ""
        self.zipCode = placemark.postalCode ?? ""
        self.state = placemark.administrativeArea ?? ""
        self.country = placemark.country ?? ""
    }
    
}
