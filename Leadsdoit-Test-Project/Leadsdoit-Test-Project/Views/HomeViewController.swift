//
//  ViewController.swift
//  Leadsdoit-Test-Project
//
//  Created by Diana on 16/01/2024.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
    
    let viewModel = HomeViewModel()
    var historyViewModel = HistoryViewModel()
    
    //MARK: - Outlets
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var roverView: UIView!
    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var calendarView: UIImageView!
    @IBOutlet weak var addView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    private var historyButtom: UIButton = {
        let buttom = UIButton.setupAction(type: .history)
        return buttom
    }()
    
    //MARK: - Private properties
    var marsData: [MarsPhotoCellModel] = []
    var filteredData: [MarsPhotoCellModel] = []
    
    var roverPickerRowsName: [String] = []
    var cameraPickerRowsName: [String] = []
    
    private lazy var cameraPicker = UIPickerView()
    private lazy var roverPicker = UIPickerView()
    private lazy var datePiker = UIDatePicker()
    private lazy var containerView = UIView()
    
    var selectedRover: String?
    var selectedCamera: String?
    var selectedDate: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        updateDate()
        cameraView.isUserInteractionEnabled = true
        roverView.isUserInteractionEnabled = true
        
        
        
        ApiManager.fetchMarsPhotos { [weak self] marsCamera in
            
            DispatchQueue.main.async {
                if let marsCamera = marsCamera {
                    self?.marsData = marsCamera.photos.map { photo in
                        return MarsPhotoCellModel(
                            roverName: photo.rover.name.rawValue,
                            cameraName: photo.camera.fullName.rawValue,
                            earthDate: photo.earthDate,
                            imageUrl: photo.imgSrc)
                    }
                    print("Right")
                    self?.updatePickerRows()
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                } else {
                    print("Ошибка при получении данных о фотографиях на Марсе.")
                }
            }
        }
        
        let cameraTapGesture = UITapGestureRecognizer(target: self, action: #selector(filterCameraTapped))
        cameraView.addGestureRecognizer(cameraTapGesture)
        
        let roverTapGesture = UITapGestureRecognizer(target: self, action: #selector(filterRoverTapped))
        roverView.addGestureRecognizer(roverTapGesture)
        
        let dateTapGesture = UITapGestureRecognizer(target: self, action: #selector(calendarTapped))
        calendarView.isUserInteractionEnabled = true
        calendarView.addGestureRecognizer(dateTapGesture)
        
        let addTapGesture = UITapGestureRecognizer(target: self, action: #selector(addTapped))
        addTapGesture.view?.isUserInteractionEnabled = true
        addView.addGestureRecognizer(addTapGesture)
    }
    
    private func updateDate() {
        dateLabel.text = viewModel.currentDate
        view.addSubview(historyButtom)
        
        historyButtom.snp.makeConstraints {
            $0.height.width.equalTo(70)
            $0.top.equalToSuperview().offset(761)
            $0.leading.equalToSuperview().offset(303)
        }
        historyButtom.addTarget(self, action: #selector(historyButtomTapped), for: .touchUpInside)
    }
    
    @objc private func historyButtomTapped() {
        viewModel.openHistoryViewController(from: self, historyViewModel: historyViewModel)
    }
    
    func updatePickerRows() {
        roverPickerRowsName = ["All"] + Array(Set(marsData.map { $0.roverName }))
        cameraPickerRowsName = ["All"] + Array(Set(marsData.map { $0.cameraName }))
        
        roverPicker.reloadAllComponents()
        cameraPicker.reloadAllComponents()
    }
    
    @objc func filterCameraTapped() {
        cameraPicker.dataSource = self
        cameraPicker.delegate = self
        
        cameraPicker.reloadAllComponents()
        
        guard containerView.superview == nil else { return }
        containerView = setupPickerContainer(for: cameraPicker, title: "Camera", closeButtonAction: #selector(closeButtonTapped), acceptButtonAction: #selector(acceptCameraTapped))
    }
    
    @objc func filterRoverTapped() {
        roverPicker.dataSource = self
        roverPicker.delegate = self
        
        roverPicker.reloadAllComponents()
        
        guard containerView.superview == nil else { return }
        containerView = setupPickerContainer(for: roverPicker, title: "Rover", closeButtonAction: #selector(closeButtonTapped), acceptButtonAction: #selector(acceptRoverTapped))
    }
    
    @objc func calendarTapped() {
        datePiker.datePickerMode = .date
        
        guard containerView.superview != nil else {
            containerView = setupDatePickerContainer(for: datePiker, title: "Date", closeButtonAction: #selector(closeButtonTapped), acceptButtonAction: #selector(acceptDateTapped))
            return
        }
    }
    
    @objc func addTapped() {
        let alert = UIAlertController(title: "Save Filters", message: "The current filters and the date you have chosen can be saved to the filter history.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: {_ in
            let filteredData = self.viewModel.filterMarsData(self.marsData)
            self.historyViewModel.filteredHistoryData += filteredData
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }
    
    @objc func closeButtonTapped() {
        containerView.removeFromSuperview()
        
    }
    @objc func acceptRoverTapped() {
        let selectedRoverIndex = roverPicker.selectedRow(inComponent: 0)
        if selectedRoverIndex == 0 {
            self.viewModel.selectedRover = nil
        } else {
            self.viewModel.selectedRover = roverPickerRowsName[selectedRoverIndex]
        }
        print("Selected Rover: \(selectedRover ?? "All")")
        containerView.removeFromSuperview()
    }
    
    @objc func acceptCameraTapped() {
        let selectedCameraIndex = cameraPicker.selectedRow(inComponent: 0)
        if selectedCameraIndex == 0 {
            self.viewModel.selectedCamera = nil
        } else {
            self.viewModel.selectedCamera = cameraPickerRowsName[selectedCameraIndex]
        }
        print("Selected Camera: \(selectedCamera ?? "All")")
        containerView.removeFromSuperview()
        
    }
    
    @objc func acceptDateTapped() {
        self.viewModel.selectedDate = datePiker.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d, yyyy"
        
        let formattedDate = dateFormatter.string(from:  self.viewModel.selectedDate!)
        print("Selected Date: \(formattedDate)")
        containerView.removeFromSuperview()
    }
}

extension HomeViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var countOfRows = 0
        if pickerView.isEqual(roverPicker) {
            countOfRows = roverPickerRowsName.count
        } else if pickerView.isEqual(cameraPicker){
            countOfRows = cameraPickerRowsName.count
        }
        return countOfRows
    }
    
    
}

extension HomeViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
        if pickerView.isEqual(roverPicker) {
            label.text = roverPickerRowsName[row]
        } else if pickerView.isEqual(cameraPicker){
            label.text = cameraPickerRowsName[row]
        }
        
        label.textAlignment = .center
        label.font = UIFont.title2
        label.textColor = .black
        return label
    }
}


extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return marsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier) as? HomeTableViewCell else {
            return UITableViewCell()
        }
        let photoModel = marsData[indexPath.row]
        cell.configure(imageURLLL: photoModel.imageUrl, roverText: photoModel.roverName, cameraText: photoModel.cameraName, dateText: photoModel.earthDate)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let fullScreenImageViewModel = viewModel.fullScreenImageViewModel(for: indexPath, marsData: marsData)
        
        let fullScreenImageVC = FullScreenImageViewController()
        fullScreenImageVC.viewModel = fullScreenImageViewModel
        fullScreenImageVC.modalPresentationStyle = .fullScreen
        
        present(fullScreenImageVC, animated: true, completion: nil)
    }
}
