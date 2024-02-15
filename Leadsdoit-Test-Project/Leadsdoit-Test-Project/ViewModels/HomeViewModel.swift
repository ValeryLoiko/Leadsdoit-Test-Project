//
//  HomeViewModel.swift
//  Leadsdoit-Test-Project
//
//  Created by Diana on 26/01/2024.
//

import UIKit

class HomeViewModel {
    
    var selectedRover: String?
    var selectedCamera: String?
    var selectedDate: Date?
    var filteredData: [MarsPhotoCellModel] = []
    var choiceData: [MarsPhotoCellModel] = []
    var useChoiceData = false
    
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
    
    func saveFilteredData(_ data: [MarsPhotoCellModel]) {
    }
    
    func filterMarsData(_ marsData: [MarsPhotoCellModel]) -> [MarsPhotoCellModel] {
        filteredData = marsData
        
        if let rover = selectedRover, rover != "All" {
            filteredData = filteredData.filter { $0.roverName == rover }
        }
        
        if let camera = selectedCamera, camera != "All" {
            filteredData = filteredData.filter { $0.cameraName == camera }
        }
        
        if let date = selectedDate {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let selectedDateString = dateFormatter.string(from: date)
            filteredData = filteredData.filter { $0.earthDate == selectedDateString }
        }
        return filteredData
    }
    
    func openHistoryViewController(from viewController: UIViewController, historyViewModel: HistoryViewModel) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let historyVC = storyboard.instantiateViewController(withIdentifier: "HistoryViewController") as? HistoryViewController {
            historyVC.viewModel = historyViewModel
            viewController.navigationController?.pushViewController(historyVC, animated: true)
        }
    }
}
