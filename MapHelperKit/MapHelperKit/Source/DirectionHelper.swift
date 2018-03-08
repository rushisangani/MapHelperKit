//
//  DirectionHelper.swift
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

@objc open class DirectionHelper: NSObject {

    // MARK: - Properties
    
    public var source: String = ""
    public var destination: String = ""
    
    /// MapType: - default is '.default' which asks user to select map if 'Google Maps' is installed.
    public var mapType: MapType = .default
    
    /// DirectionMode mode: - default is Driving
    public var directionMode: DirectionMode = .driving
    
    // MARK: - Initialize
    
    public init(source: String, destination: String) {
        self.source = source
        self.destination = destination
    }
    
    public convenience init(destination: String) {
        self.init(source: "", destination: destination)
    }
    
    // MARK:- Public
    
    /// show direction for specified address from user's current location
    @objc public func showDirection(){
        
        // check if google map is not installed then open in apple map
        if !self.canOpenGoogleMap() || mapType == .appleMap {
            showDirectionsInMap(map: .appleMap)
            return
        }
        
        // ask to choose between google or apple map for 'default' type
        if mapType == .default {
            
            AlertHelper.selectMapOption(title: titleShowDirections, completion: { (selected) in
                if selected == titleAppleMaps {
                    self.showDirectionsInMap(map: .appleMap)
                }else {
                    self.showDirectionsInMap(map: .googleMap)
                }
            })
        }else{
            showDirectionsInMap(map: .googleMap)
        }
    }
}

// MARK:- Directions in Maps
extension DirectionHelper {
    
    /// show directions in map
    private func showDirectionsInMap(map: MapType) {
        var urlString = (map == .appleMap) ? "\(appleMapURLScheme)?" : "\(googleMapURLScheme)?"
        let direction = directionMode.queryString(for: map)
        
        // source
        if !source.isEmpty {
            urlString.append("saddr=\(source)&")
        }
        
        // destination
        if !destination.isEmpty {
            urlString.append("daddr=\(destination)&")
        }
        
        // direction mode
        urlString.append(direction)
        
        // open
        self.openMapURL(url: urlString)
    }
}


