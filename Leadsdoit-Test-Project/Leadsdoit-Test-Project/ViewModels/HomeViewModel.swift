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
    }
    
    func acceptButtonTapped() {
        print("accept")
    }
    
    func fullScreenImageViewModel(for indexPath: IndexPath, marsData: [MarsPhotoCellModel]) -> FullScreenImageViewModel {
           let photoModel = marsData[indexPath.row]
           let viewModel = FullScreenImageViewModel()
           viewModel.imageURL = photoModel.imageUrl
           return viewModel
       }
}
