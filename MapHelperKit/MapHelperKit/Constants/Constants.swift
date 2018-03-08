//
//  Constants.swift
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

/* URL Schemes */
let googleMapURLScheme  = "comgooglemaps://"
let appleMapURLScheme   = "http://maps.apple.com/"

/* Titles */
let titleOpenAddressIn  = "Open Address In"
let titleShowDirections = "Show Directions In"
let titleGoogleMaps     = "Google Maps"
let titleAppleMaps      = "Apple Maps"
let titleCancel         = "Cancel"

/* Errors */
let titleError          = "Error"
let googleMapErrorMessage = "Can not open Google Maps"

/* Other */
let defaultZoomLevel    = 14

/* Enum MapType */
@objc public enum MapType: Int {
    
    case `default` = 0  // Default: Ask user for selection of map
    case googleMap
    case appleMap
}

/* Enum MapView */
@objc public enum MapViewMode: Int {
    
    case standard = 0  // Default
    case satellite
    case transit
    
    /// get query string based on map type
    public func queryString(for mapType: MapType) -> String {
        switch self {
        case .standard:
            return (mapType == .googleMap) ? "views=roadmap" : "t=m"
        case .satellite:
            return (mapType == .googleMap) ? "views=satellite" : "t=k"
        case .transit:
            return (mapType == .googleMap) ? "views=transit" : "t=r"
        }
    }
}

/* Enum Direction Mode */

@objc public enum DirectionMode: Int {
    
    case driving = 0  // Default
    case publicTransit
    case walking
    
    /// get query string based on map type
    public func queryString(for mapType: MapType) -> String {
        switch self {
        case .driving:
            return (mapType == .googleMap) ? "directionsmode=driving" : "dirflg=d"
        case .publicTransit:
            return (mapType == .googleMap) ? "directionsmode=transit" : "dirflg=r"
        case .walking:
            return (mapType == .googleMap) ? "directionsmode=walking" : "dirflg=w"
        }
    }
}


/* NSObject Extension */
extension NSObject {
    
    /// checks if google map is installed or can open google map
    func canOpenGoogleMap() -> Bool {
        return UIApplication.shared.canOpenURL(URL(string: googleMapURLScheme)!)
    }
    
    /// open map url
    func openMapURL(url: String) {
        if let mapURL = URL(string: url.encodedURLString()) {
            if UIApplication.shared.canOpenURL(mapURL){
                UIApplication.shared.openURL(mapURL)
            }
        }
    }
}

/* String URL encoding */
extension String {
    func encodedURLString() -> String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? self
    }
}
