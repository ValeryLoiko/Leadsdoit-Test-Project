//
//  ViewController.swift
//  Leadsdoit-Test-Project
//
//  Created by Diana on 16/01/2024.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var roverView: UIView!
    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var calendar: UIImageView!
    @IBOutlet weak var add: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    private var historyButtom: UIButton = {
        let buttom = UIButton.setupAction(type: .history)
        return buttom
    }()
    
    //MARK: - Private properties
    var marsData: [MarsPhotoCellModel] = []
    var roverPickerRowsName: [String] = []
    var cameraPickerRowsName: [String] = []
    
    var viewModel = HomeViewModel()
    
    private lazy var cameraPicker = UIPickerView()
    private lazy var roverPicker = UIPickerView()
    private lazy var containerView = UIView()
    
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
        print("history")
        
        let historyVC = HistoryViewController()
//        historyVC.modalPresentationStyle = .overFullScreen
//        present(historyVC, animated: true)
        historyVC.navigationItem.leftBarButtonItem = nil
        navigationController?.pushViewController(historyVC, animated: true)
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
        
        guard containerView.superview != nil else {
            containerView = setupPickerContainer(for: roverPicker, title: "Rover", closeButtonAction: #selector(closeButtonTapped), acceptButtonAction: #selector(acceptRoverTapped))
            return
        }
    }
    
    @objc func filterRoverTapped() {
        roverPicker.dataSource = self
        roverPicker.delegate = self
        
        guard containerView.superview != nil else {
            containerView = setupPickerContainer(for: roverPicker, title: "Rover", closeButtonAction: #selector(closeButtonTapped), acceptButtonAction: #selector(acceptRoverTapped))
            return
        }
        
    }
    
    @objc func closeButtonTapped() {
        containerView.removeFromSuperview()
        
    }
    @objc func acceptRoverTapped() {
        viewModel.acceptButtonTapped()
    }
    
    @objc func acceptCameraTapped() {
        viewModel.acceptButtonTapped()
    }
}

extension HomeViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.isEqual(roverPicker) {
            return roverPickerRowsName.count
        } else {
            return cameraPickerRowsName.count
        }
    }
}

extension HomeViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
        if pickerView.isEqual(roverPicker) {
            label.text = roverPickerRowsName[row]
        } else {
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
