//
//  UIDatePicker + Ext.swift
//  Leadsdoit-Test-Project
//
//  Created by Diana on 07/02/2024.
//

import UIKit
import SnapKit

extension HomeViewController {
    func setupDatePickerContainer(for picker: UIDatePicker, title: String, closeButtonAction: Selector, acceptButtonAction: Selector) -> UIView{
        lazy var containerView = UIView()
        
        containerView.layer.cornerRadius = 50
        containerView.layer.borderColor = UIColor.black.cgColor
        containerView.layer.borderWidth = 1
        containerView.backgroundColor = .white
        
        let closeButton = UIButton.setupAction(type: .exit)
        let acceptButton = UIButton.setupAction(type: .accept)
        
        closeButton.addTarget(self, action: closeButtonAction, for: .touchUpInside)
        acceptButton.addTarget(self, action: acceptButtonAction, for: .touchUpInside)
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.title2
        titleLabel.textAlignment = .center
        
        view.addSubview(containerView)
        containerView.addSubview(closeButton)
        containerView.addSubview(acceptButton)
        containerView.addSubview(titleLabel)
        containerView.addSubview(picker)
        
        containerView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(306)
        }
        
        closeButton.snp.makeConstraints {
            $0.left.equalTo(containerView).inset(20)
            $0.top.equalTo(containerView).inset(20)
            $0.width.equalTo(44)
            $0.height.equalTo(44)
        }
        
        titleLabel.snp.makeConstraints {
            $0.width.equalTo(82)
            $0.height.equalTo(28)
            $0.top.equalTo(containerView).inset(26)
            $0.centerX.equalToSuperview()
        }
        
        acceptButton.snp.makeConstraints {
            $0.right.equalTo(containerView).inset(20)
            $0.top.equalTo(containerView).inset(20)
            $0.width.equalTo(44)
            $0.height.equalTo(44)
        }
        
        picker.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(242)
            $0.bottom.equalTo(containerView)
        }
        return containerView
    }
}

