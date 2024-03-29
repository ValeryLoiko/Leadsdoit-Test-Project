//
//  HomeTableViewCell.swift
//  Leadsdoit-Test-Project
//
//  Created by Diana on 19/01/2024.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    static let identifier = "HomeTableViewCell"
    
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
    
    private lazy var roverLabel: UILabel = {
        return createLabel()
    }()
    
    private lazy var cameraLabel: UILabel = {
        return createLabel()
    }()
    
    private lazy var dateLabel: UILabel = {
        return createLabel()
    }()
    
    private lazy var cameraImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private func createLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 8, weight: .thin)
        return label
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure(imageURLLL: String, roverText: String, cameraText: String, dateText: String) {
        
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
        
        
        if let url = URL(string: imageURLLL ) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url),
                   let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.cameraImage.image = image
                    }
                }
            }
        }
        
        roverLabel.attributedText = attributedRoverText
        cameraLabel.attributedText = attributedCameraText
        dateLabel.attributedText = attributedDateText
        
        
    }
}

private extension HomeTableViewCell {
    func setupUI() {
        addSubview(cornerView)
        cornerView.addSubview(roverLabel)
        cornerView.addSubview(cameraLabel)
        cornerView.addSubview(dateLabel)
        cornerView.addSubview(cameraImage)
        
        cameraLabel.numberOfLines = 2
        
        cornerView.snp.makeConstraints {
            $0.width.equalTo(353)
            $0.height.equalTo(150)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        roverLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(10)
            $0.width.equalTo(187)
            $0.top.equalToSuperview().offset(10)
        }
        
        cameraLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(10)
            $0.width.equalTo(187)
            $0.top.equalTo(roverLabel.snp.bottom).offset(10)
        }
        
        dateLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(10)
            $0.width.equalTo(187)
            $0.top.equalTo(cameraLabel.snp.bottom).offset(10)
        }
        cameraImage.snp.makeConstraints{
            $0.width.equalTo(130)
            $0.height.equalTo(130)
            $0.right.equalToSuperview().inset(10)
            $0.top.equalToSuperview().offset(10)
        }
    }
}
