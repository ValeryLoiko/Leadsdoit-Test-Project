//
//  HistoryViewModel.swift
//  Leadsdoit-Test-Project
//
//  Created by Diana on 04/02/2024.
//

import Foundation

class HistoryViewModel {
    
    var filteredHistoryData: [MarsPhotoCellModel] = []
    
    func deleteSelectedCells(at index: Int) {
        guard index >= 0 && index < filteredHistoryData.count else { return }
        
        let selectedPhoto = filteredHistoryData[index]
        filteredHistoryData = filteredHistoryData.filter { photo in
            return !(photo.roverName == selectedPhoto.roverName &&
                     photo.cameraName == selectedPhoto.cameraName &&
                     photo.earthDate == selectedPhoto.earthDate)
        }
    }
}

