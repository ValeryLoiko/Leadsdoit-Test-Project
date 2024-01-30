//
//  HomeViewModel.swift
//  Leadsdoit-Test-Project
//
//  Created by Diana on 26/01/2024.
//

import UIKit

class HomeViewModel {
    var currentDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d, yyyy"
        return dateFormatter.string(from: Date())
    }
    
       func cameraPickerTapped() -> UIPickerView {
           let cameraPicker = UIPickerView.showPickerView(title: "Camera")
           return cameraPicker
       }

       func roverPickerTapped() -> UIPickerView {
           let roverPicker = UIPickerView.showPickerView(title: "Rover")
           return roverPicker
       }
}
