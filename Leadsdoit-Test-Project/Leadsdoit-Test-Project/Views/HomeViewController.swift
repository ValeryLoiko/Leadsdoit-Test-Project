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
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: "HomeTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
}


extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell") as? HomeTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(imageURL: "star", roverText: "Curiosity", cameraText: "Front Hazard Avoidance Camera", dateText: "June 6, 2019")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    
}
