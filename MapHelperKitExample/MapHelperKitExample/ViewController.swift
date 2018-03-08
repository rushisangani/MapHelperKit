//
//  ViewController.swift
//  MapHelperKitExample
//
//  Created by Rushi on 07/03/18.
//  Copyright © 2018 Rushi Sangani. All rights reserved.
//

import UIKit
import MapHelperKit

class ViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var textField2: UITextField!
    @IBOutlet weak var textFieldStackView: UIStackView!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        //textField2.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK:- Actions
    @IBAction func segmentControl(_ sender: Any) {
        textField2.isHidden = (segmentControl.selectedSegmentIndex == 0)
    }
    
    @IBAction func showInMapClicked(_ sender: Any) {
        view.endEditing(true)
        
        let address1 = textField1.text ?? ""
        let address2 = textField2.text ?? ""
        
        if segmentControl.selectedSegmentIndex == 0 {
            
            let mapHelper = MapHelper(placeName: address1)
            mapHelper.openInMap()
        }
        else {
            let directionHelper = DirectionHelper(source: address1, destination: address2)
            directionHelper.showDirection()
        }
    }
    
    @IBAction func showInGoogleMapClicked(_ sender: Any) {
        view.endEditing(true)
        
        let address1 = textField1.text ?? ""
        let address2 = textField2.text ?? ""
        
        if segmentControl.selectedSegmentIndex == 0 {
            
            let mapHelper = MapHelper(placeName: address1)
            mapHelper.mapType = .googleMap
            mapHelper.mapViewMode = .standard
            mapHelper.openInMap()
        }
        else {
            let directionHelper = DirectionHelper(source: address1, destination: address2)
            directionHelper.mapType = .googleMap
            directionHelper.directionMode = .driving
            directionHelper.showDirection()
        }
    }
    
    @IBAction func showInAppleMapClicked(_ sender: Any) {
        view.endEditing(true)
        
        let address1 = textField1.text ?? ""
        let address2 = textField2.text ?? ""
        
        if segmentControl.selectedSegmentIndex == 0 {
            
            let mapHelper = MapHelper(placeName: address1)
            mapHelper.mapType = .appleMap
            mapHelper.mapViewMode = .satellite
            mapHelper.openInMap()
        }
        else {
            let directionHelper = DirectionHelper(source: address1, destination: address2)
            directionHelper.mapType = .appleMap
            directionHelper.showDirection()
        }
    }
}

// MARK: - UITextFieldDelegate
extension ViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
