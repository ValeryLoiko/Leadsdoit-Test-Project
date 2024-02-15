//
//  HistoryViewController.swift
//  Leadsdoit-Test-Project
//
//  Created by Diana on 04/02/2024.
//

import UIKit
import SnapKit
import UIColorHexSwift

protocol HistoryViewControllerDelegate: AnyObject {
    func didSelectFilterData(_ data: [MarsPhotoCellModel])
}

class HistoryViewController: UIViewController {
    
    var viewModel = HistoryViewModel()
    let homeViewModel = HomeViewModel()
    weak var delegate: HistoryViewControllerDelegate?

    
    private lazy var containerView = UIView()
    private lazy var backButton: UIButton = {
        var button = UIButton(type: .custom)
        button = UIButton.setupAction(type: .left)
        button.addTarget(self, action: #selector(backButtonTap), for: .touchUpInside)
        return button
    }()
    private lazy var titleLabel: UILabel = {
        let title = UILabel()
        title.text = "History"
        title.font = UIFont.largeTitle
        title.textAlignment = .center
        return title
    }()
    
    private lazy var emptyImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "historyEmpty")
        return imageView
    }()
    
    private lazy var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureView()
        tableView.reloadData()
    }
    
    
    private func configureView() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        containerView.backgroundColor = UIColor("#FF692C")
        view.backgroundColor = .white
        
        view.addSubview(containerView)
        containerView.addSubview(backButton)
        containerView.addSubview(titleLabel)
        
        if !viewModel.filteredHistoryData.isEmpty {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(HistoryTableViewCell.self, forCellReuseIdentifier: HistoryTableViewCell.identifier)
            
            view.addSubview(tableView)
            tableView.snp.makeConstraints {
                $0.leading.trailing.bottom.equalToSuperview()
                $0.top.equalTo(containerView.snp.bottom)
            }
        } else {
            view.addSubview(emptyImage)
            
            emptyImage.snp.makeConstraints {
                $0.width.equalTo(193)
                $0.height.equalTo(186)
                $0.center.equalToSuperview()
            }
        }
        
        containerView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalToSuperview()
            $0.height.equalTo(132)
        }
        
        backButton.snp.makeConstraints {
            $0.width.height.equalTo(44)
            $0.top.equalToSuperview().inset(68)
            $0.leading.equalToSuperview().inset(20)
        }
        
        titleLabel.snp.makeConstraints {
            $0.height.equalTo(42)
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(69)
        }
    }
    
    @objc private func backButtonTap() {
        navigationController?.popViewController(animated: true)
    }
    
    func didSelectData(_ data: [MarsPhotoCellModel]) {
        delegate?.didSelectFilterData(data)
        navigationController?.popViewController(animated: true)
    }
}

extension HistoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredHistoryData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HistoryTableViewCell.identifier) as? HistoryTableViewCell else {
            return UITableViewCell()
        }
        
        let historyModel = viewModel.filteredHistoryData[indexPath.row]
        cell.configure(roverText: historyModel.roverName, cameraText: historyModel.cameraName, dateText: historyModel.earthDate)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 136
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alert = UIAlertController(title: "Menu Filter", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Use", style: .default, handler: { _ in
            let selectedData = self.viewModel.sendChoiceData(at: indexPath.row)
            self.didSelectData(selectedData)
        }))
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
            self.viewModel.deleteSelectedCells(at: indexPath.row)
            tableView.reloadData()
        
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }
}

