//
//  Geocoder.swift
//  MapHelperKit
//
//  Copyright (c) 2017 Rushi Sangani
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Foundation
import CoreLocation

extension MapHelper {
    
    /// convert coordinates to address
    func convertCoordindatesToPlace(_ completion: @escaping (_ place: String)->()) {
        
        // convert coordindates to place only when - flag is true, lat, long is specified, & place is empty
        guard convertCoordinatesToAddress, !latitude.isEmpty, !longitude.isEmpty, placeName.isEmpty else {
            completion("")
            return
        }
        
        // convert to location degrees
        guard let lat = CLLocationDegrees(latitude), let long = CLLocationDegrees(longitude) else {
            completion("")
            return
        }
        
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: lat, longitude: long)
        
        geoCoder.reverseGeocodeLocation(location) { (placemarks, error) in
            guard error == nil, let placeMark = placemarks?.first else {
                completion("")
                return
            }
            
            // create address string
            var addressString = ""
            if let name = placeMark.name {
                addressString.append("\(name),")
            }
            if let locality = placeMark.locality {
                addressString.append("\(locality),")
            }
            if let area = placeMark.administrativeArea {
                addressString.append("\(area)")
            }
            
            // get final place name
            completion(addressString)
        }
    }
}
