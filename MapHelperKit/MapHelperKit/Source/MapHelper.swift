//
//  MapHelper.swift
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

import UIKit

@objc open class MapHelper: NSObject {
    
    // MARK: - Properties
    
    public var placeName: String = ""
    public var latitude: String = ""
    public var longitude: String = ""
    
    /// MapType: - default is '.default' which asks user to select map if 'Google Maps' is installed.
    public var mapType: MapType = .default
    
    /// MapView mode: - default is Standard
    public var mapViewMode: MapViewMode = .standard
    
    /// zoom level for map: - default is 14
    public var zoomLevel: Int = defaultZoomLevel
    
    /// convert coordinates to address: - default is false (for faster response)
    public var convertCoordinatesToAddress: Bool = false

    // MARK: - Initialize
    
    public init(placeName: String, latitude: String, longitude: String) {
        self.placeName = placeName
        self.latitude = latitude
        self.longitude = longitude
    }
    
    public convenience init(placeName: String) {
        self.init(placeName: placeName, latitude: "", longitude: "")
    }
    
    public convenience init(latitude: String, longitude: String) {
        self.init(placeName: "", latitude: latitude, longitude: longitude)
    }
    
    // MARK:- Public
    
    /// open specified address or lat,long in map
    @objc public func openInMap() {
        
        // check if google map is not installed then open in apple map
        if !self.canOpenGoogleMap() || mapType == .appleMap {
            showPlaceInAppleMap()
            return
        }
        
        // ask to choose between google or apple map for 'default' type
        if mapType == .default {
            
            AlertHelper.selectMapOption(title: titleOpenAddressIn, completion: { (selected) in
                if selected == titleAppleMaps {
                    self.showPlaceInAppleMap()
                }else {
                    self.showPlaceInGoogleMap()
                }
            })
        }else{
            showPlaceInGoogleMap()
        }
    }
}

// MARK:- Open in Maps
extension MapHelper {
    
    /// show place in google map
    private func showPlaceInGoogleMap() {
        var urlString = "\(googleMapURLScheme)?"
        
        // add place
        if !placeName.isEmpty {
            urlString.append("q=\(placeName)&")
        }
        
        // add lat,long
        if !latitude.isEmpty && !longitude.isEmpty {
            urlString.append("center=\(latitude),\(longitude)&")
        }
        
        // add mapview mode and zoom level
        urlString.append("\(mapViewMode.queryString(for: .googleMap))&zoom=\(zoomLevel)")
        
        // convert coordinates to place if required, otherwise open directly
        self.convertCoordindatesToPlace { (place) in
            if !place.isEmpty {
                
                self.placeName = place
                urlString.append("&q=\(place)")
            }
            
            // open
            self.openMapURL(url: urlString)
        }
    }
    
    /// show place in apple map
    private func showPlaceInAppleMap() {
        var urlString = "\(appleMapURLScheme)?"
        
        // add place
        if !placeName.isEmpty {
            urlString.append("q=\(placeName)&")
        }
        
        // add lat,long
        if !latitude.isEmpty && !longitude.isEmpty {
            urlString.append("sll=\(latitude),\(longitude)&")
        }
        
        // add mapview mode and zoom level
        urlString.append("\(mapViewMode.queryString(for: .appleMap))&z=\(zoomLevel)")
        
        // convert coordinates to place if required, otherwise open directly
        self.convertCoordindatesToPlace { (place) in
            if !place.isEmpty {
                
                self.placeName = place
                urlString.append("&q=\(place)")
            }
            
            // open
            self.openMapURL(url: urlString)
        }
    }
}
