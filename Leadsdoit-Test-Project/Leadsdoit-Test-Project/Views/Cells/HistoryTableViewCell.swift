//
//  HistoryTableViewCell.swift
//  Leadsdoit-Test-Project
//
//  Created by Diana on 05/02/2024.
//

import UIKit
import UIColorHexSwift
import SnapKit

class HistoryTableViewCell: UITableViewCell {
    
    static let identifier = "HistoryTableViewCell"
    
    private lazy var cornerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.backgroundColor = .white
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.4
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        view.layer.shadowRadius = 5
        return view
    }()
    
    private lazy var orangeLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor("#FF692C")
        return view
    }()
    
    private lazy var filterLabel: UILabel = {
        let label = UILabel()
        label.text = "Filters"
        label.font = UIFont.title2
        label.textColor = UIColor("#FF692C")
        label.textAlignment = .center
        return label
    }()
    
    private lazy var roverLabel: UILabel = {
        return createLabel()
    }()
    
    private lazy var cameraLabel: UILabel = {
        return createLabel()
    }()
    
    private lazy var dateLabel: UILabel = {
        return createLabel()
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    func configure(roverText: String, cameraText: String, dateText: String) {
        
        let grayAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.gray,
            .font: UIFont.systemFont(ofSize: 15, weight: .regular)
        ]
        
        let body2Attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black,
            .font: UIFont.body2!
        ]
        
        let attributedRoverText = NSMutableAttributedString(string: "Rover: ", attributes: grayAttributes)
        let attributedCameraText = NSMutableAttributedString(string: "Camera: ", attributes: grayAttributes)
        let attributedDateText = NSMutableAttributedString(string: "Date: ", attributes: grayAttributes)
        
        attributedRoverText.append(NSAttributedString(string: roverText, attributes: body2Attributes))
        attributedCameraText.append(NSAttributedString(string: cameraText, attributes: body2Attributes))
        attributedDateText.append(NSAttributedString(string: dateText, attributes: body2Attributes))
        
        roverLabel.attributedText = attributedRoverText
        cameraLabel.attributedText = attributedCameraText
        dateLabel.attributedText = attributedDateText
    }
}

private extension HistoryTableViewCell {
    func setupUI() {
        addSubview(cornerView)
        cornerView.addSubview(orangeLine)
        cornerView.addSubview(filterLabel)
        cornerView.addSubview(roverLabel)
        cornerView.addSubview(cameraLabel)
        cornerView.addSubview(dateLabel)
        
        cornerView.snp.makeConstraints {
            $0.width.equalTo(353)
            $0.height.equalTo(136)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        orangeLine.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.width.equalTo(251)
            $0.top.equalToSuperview().inset(24)
            $0.height.equalTo(1)
        }
        
        filterLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.top.equalToSuperview().inset(10)
        }
        roverLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(filterLabel.snp.bottom).offset(6)
        }
        
        cameraLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(roverLabel.snp.bottom).offset(6)
        }
        
        dateLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(cameraLabel.snp.bottom).offset(6)
        }
    }
}
