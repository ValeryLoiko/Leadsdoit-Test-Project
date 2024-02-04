//
//  HistoryViewController.swift
//  Leadsdoit-Test-Project
//
//  Created by Diana on 04/02/2024.
//

import UIKit
import SnapKit

class HistoryViewController: UIViewController {
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        configureView()
      
    }
    
    private func configureView() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        containerView.backgroundColor = .orange
        
        view.addSubview(containerView)
        containerView.addSubview(backButton)
        containerView.addSubview(titleLabel)
        
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
        print("back")
        navigationController?.popViewController(animated: true)
    }
    
}


