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
        
    func closeButtonTapped(pickerView: UIPickerView) {
        print("close")
        pickerView.resignFirstResponder()
    }
    
    func acceptButtonTapped() {
        print("accept")
    }
}
