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
    @IBOutlet weak var filterCamera: UIView!
    @IBOutlet weak var roverCamera: UIView!
    @IBOutlet weak var calendar: UIImageView!
    @IBOutlet weak var add: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Private properties
    var marsData: [MarsPhotoCellModel] = []
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: "HomeTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
    
        // Вызываем метод fetchMarsPhotos из ApiManager
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
                      DispatchQueue.main.async {
                          self?.tableView.reloadData()
                      }
                  } else {
                      // Произошла ошибка при получении данных
                      print("Ошибка при получении данных о фотографиях на Марсе.")
                  }
              }
          }
    
    }
}


extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return marsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell") as? HomeTableViewCell else {
            return UITableViewCell()
        }
        let photoModel = marsData[indexPath.row]
        cell.configure(imageURLLL: photoModel.imageUrl, roverText: photoModel.roverName, cameraText: photoModel.cameraName, dateText: photoModel.earthDate)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    
}
