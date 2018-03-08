# MapHelperKit
MapHelperKit provides an elegant way to show locations or directions in Google Maps or Apple Maps.

![Alt text](/Images/image1.png?raw=true "Google Map")
![Alt text](/Images/image2.png?raw=true "Apple Map")

## Features

- Easiest way to show locations or directions in map.
- MapHelperKit opens Apple Maps automatically, if Google Map is not installed on the device.
- Default mode asks user to show address in Google Map or Apple Map.
- Show directions with different direction mode.

## Requirements

- iOS 9.0+
- Xcode 8.3+
- Swift 4.0

## Installation

### CocoaPods

```ruby
pod 'MapHelperKit'
or
pod 'MapHelperKit', '~> 1.1'
```

## Usage

**Note:** - To open Google Maps from iOS App please include following in your info.plist
```swift
<array>
    <string>comgooglemaps</string>
</array>
```
### Show Place In Map

```swift
let address = "One Infinite Loop Cupertino, CA"
let mapHelper = MapHelper(placeName: address)
mapHelper.openInMap()
```
- Provide MapViewMode
```swift
mapHelper.mapViewMode = .satellite    // Default is StandardView
```
- Provide Zoom Level
```swift
mapHelper.zoomLevel = 10             // Default is 14
```

- Provide Map Type
```swift
mapHelper.mapType = .googleMap      // Default is '.default', let's ask user to select map to open
```

### Show Directions In Map
- Show directions from Current Location

```swift
let address = "One Infinite Loop Cupertino, CA"
let directionHelper = DirectionHelper(destination: address)
directionHelper.showDirection()
```

- Show Direction from Source to Destination

```swift
let address1 = "One Infinite Loop Cupertino, CA"
let address2 = "Apple Fitness Center, 10627 Bandley Dr, Cupertino, CA"
let directionHelper = DirectionHelper(source: address1, destination: address2)
directionHelper.showDirection()
```

- Provide Direction Mode
```swift
directionHelper.directionMode = .walking      // Default is 'Driving'
```

### Example
See [Example](https://github.com/rushisangani/MapHelperKit/tree/master/MapHelperKitExample) for more details.

## License

MapHelperKit is released under the MIT license. [See LICENSE](https://github.com/rushisangani/MapHelperKit/blob/master/LICENSE) for details.
