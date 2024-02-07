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
    
    func filterMarsData(_ marsData: [MarsPhotoCellModel]) -> [MarsPhotoCellModel] {
        var filteredData = marsData
        
        if let rover = selectedRover, rover != "All" {
            filteredData = filteredData.filter { $0.roverName == rover }
        }
        
        if let camera = selectedCamera, camera != "All" {
            filteredData = filteredData.filter { $0.cameraName == camera }
        }
        
        if let date = selectedDate {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMMM d, yyyy"
            let selectedDateString = dateFormatter.string(from: date)
            filteredData = filteredData.filter { $0.earthDate == selectedDateString }
        }
        return filteredData
    }
    
//    func prepareFilteredData(_ marsData: [MarsPhotoCellModel]) -> [MarsPhotoCellModel] {
//        return filterMarsData(marsData)
//    }
    func prepareFilteredData(_ marsData: [MarsPhotoCellModel]) -> [MarsPhotoCellModel] {
        print(selectedRover)
        print(selectedCamera)
        print(selectedDate)
        var filteredData = marsData
        
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
        print(filteredData)
        return filteredData
    }
}
