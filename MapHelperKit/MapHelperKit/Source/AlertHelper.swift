//
//  AlertHelper.swift
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

class AlertHelper {
    
    // MARK: - Properties
    
    /// rootViewController to show alerts
    private static var rootViewController: UIViewController {
        return (UIApplication.shared.keyWindow?.rootViewController)!
    }
    
    // MARK:- Public
    
    /// show alert to choose from google or apple map
    static func selectMapOption(title: String, completion: @escaping (_ selection: String) -> ()) {
        
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .actionSheet)
        
        // google map action
        let googleMapAction = UIAlertAction(title: titleGoogleMaps, style: .default) { (action) in
            completion(action.title ?? titleGoogleMaps)
        }
        
        // apple map action
        let appleMapAction = UIAlertAction(title: titleAppleMaps, style: .default) { (action) in
            completion(action.title ?? titleAppleMaps)
        }
        
        // cancel action
        let cancelAction = UIAlertAction(title: titleCancel, style: .cancel) { (action) in
        }
        
        alertController.addAction(googleMapAction)
        alertController.addAction(appleMapAction)
        alertController.addAction(cancelAction)
        
        // show
        rootViewController.present(alertController, animated: true, completion: nil)
    }
    
}
